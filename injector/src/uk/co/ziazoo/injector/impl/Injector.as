package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;
  import flash.utils.getQualifiedClassName;

  import uk.co.ziazoo.fussy.Fussy;
  import uk.co.ziazoo.fussy.Reflector;
  import uk.co.ziazoo.fussy.model.Constructor;
  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.injector.IConfiguration;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IInjectionPoint;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IPrivateConfiguration;
  import uk.co.ziazoo.injector.IPrivateMapper;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  public class Injector implements IInjector
  {
    private var _dependencyFactory:DependencyFactory;
    private var _injectionPointFactory:InjectionPointFactory;

    private var _mapper:IMapperList;
    private var eagerQueue:IEagerQueue;
    private var detailsFactory:ITypeInjectionDetailsFactory;
    private var _parent:IInjector;
    private var _applicationDomain:ApplicationDomain;

    /**
     * Creates in instance of the Injector, the default implementation of
     * the IInjector interface
     *
     * @param mapper used to stop this injectors mappings
     * @param eagerQueue stores mappings in need of eager creation
     * @param detailsFactory provides ITypeInjectionDetails
     * @param parent injector if this is a child instance
     */
    public function Injector(mapper:IMapper, eagerQueue:IEagerQueue,
            detailsFactory:ITypeInjectionDetailsFactory,
            parent:IInjector = null, applicationDomain:ApplicationDomain = null)
    {
      this.eagerQueue = eagerQueue;
      this.detailsFactory = detailsFactory;
      _mapper = new MapperList(mapper);
      _parent = parent;
      _applicationDomain = applicationDomain;
    }

    /**
     * Creates in instance of IInjector
     * @param configuration to be installed into new injector (optional)
     * @return new injector instance
     */
    public static function createInjector(configuration:IConfiguration = null):IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();

      var detailsFactory:ITypeInjectionDetailsFactory =
              new FussyTypeDetailsFactory(new Fussy().query());

      var mapper:IMapper = new Mapper(
              new MappingBuilderFactory(eagerQueue,
                      detailsFactory, ApplicationDomain.currentDomain),
              ApplicationDomain.currentDomain);

      var injector:Injector = new Injector(mapper, eagerQueue, detailsFactory);

      if (configuration)
      {
        injector.install(configuration);
      }

      injector.injectEagerQueue();
      return injector
    }


    /**
     * @inheritDoc
     */
    public function map(type:Class):IMappingBuilder
    {
      return mapper.map(type);
    }

    /**
     *  @inheritDoc
     */
    public function inject(object:Object, name:String = ""):Object
    {
      injectEagerQueue();

      var mapping:IMapping = findMapping(object, name);
      if (!mapping)
      {
        mapping = mapper.justInTimeMap(getClass(object)).baseMapping;
      }

      var result:Object = injectMapping(mapping);
      _mapper.injectionComplete();
      return result;
    }

    private function injectMapping(mapping:IMapping):Object
    {
      var dependency:IDependency =
              dependencyFactory.forProvider(mapping.provider);

      return create(dependency).finalArtifact;
    }

    private function create(dependency:IDependency):IDependency
    {
      var provider:IProvider = dependency.provider;
      if (!provider.requiresInjection)
      {
        return dependency;
      }

      if (!provider.instanceCreated)
      {
        var constructor:Constructor = dependency.injectionDetails.constructor;

        if (constructor.parameters.length)
        {
          var injectionPoint:IInjectionPoint =
                  injectionPointFactory.forConstructor(dependency.injectionDetails);

          for each(var child:IDependency in injectionPoint.getDependencies())
          {
            create(child);
          }
          provider.setDependencies(injectionPoint.getDependencies());
        }
      }

      injectMethodDependencies(dependency);
      injectPropertyDependencies(dependency);
      invokeCompletionCallback(dependency);

      return dependency;
    }

    private function invokeCompletionCallback(dependency:IDependency):void
    {
      var method:Method = dependency.injectionDetails.postConstructMethod;

      if (method)
      {
        method.invoke(dependency.getObject());
      }
    }

    private function injectPropertyDependencies(dependency:IDependency):void
    {
      var injectionPoints:Array =
              injectionPointFactory.forProperties(dependency.injectionDetails);

      var instance:Object = dependency.getObject();

      for each(var injectionPoint:PropertyInjectionPoint in injectionPoints)
      {
        for each(var child:IDependency in injectionPoint.getDependencies())
        {
          injectionPoint.property.setter(instance, create(child).finalArtifact);
        }
      }
    }

    private function injectMethodDependencies(dependency:IDependency):void
    {
      var injectionPoints:Array =
              injectionPointFactory.forMethods(dependency.injectionDetails);

      for each(var injectionPoint:MethodInjectionPoint in injectionPoints)
      {
        var args:Array = [];
        for each(var child:IDependency in injectionPoint.getDependencies())
        {
          args.push(create(child).finalArtifact);
        }
        injectionPoint.method.invoke(dependency.getObject(), args);
      }
    }

    internal function injectEagerQueue():void
    {
      while (eagerQueue.length > 0)
      {
        injectMapping(eagerQueue.pop());
      }
    }

    /**
     *  @inheritDoc
     */
    public function install(configuration:IConfiguration):void
    {
      configuration.configure(mapper);

      injectEagerQueue();
    }

    /**
     * @inheritDoc
     */
    public function installPrivate(configuration:IPrivateConfiguration):IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();

      var privateMapper:IPrivateMapper = new PrivateMapper(
              new MappingBuilderFactory(eagerQueue, detailsFactory, applicationDomain),
              _mapper, applicationDomain);

      configuration.configure(privateMapper);

      return new Injector(privateMapper, eagerQueue, detailsFactory, this);
    }


    /**
     * @inheritDoc
     */
    public function createChildInjector(applicationDomain:ApplicationDomain = null):IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();
      var detailsFactory:ITypeInjectionDetailsFactory =
              new FussyTypeDetailsFactory(new Fussy(new Reflector(applicationDomain))
                      .query());

      var childMapper:IMapper = new Mapper(new MappingBuilderFactory(
              eagerQueue, detailsFactory, applicationDomain), applicationDomain);

      return new Injector(childMapper, eagerQueue, detailsFactory, this, applicationDomain);
    }

    /**
     * @inheritDoc
     */
    public function getMapping(type:Class, name:String = ""):IMapping
    {
      var mapping:IMapping = findMapping(type, name);
      if (!mapping)
      {
        if (parent)
        {
          return parent.getMapping(type, name);
        }
        return justInTimeMap(type, name);
      }
      return mapping;
    }

    /**
     * @inheritDoc
     */
    public function justInTimeMap(type:Class, name:String):IMapping
    {
      return mapper.justInTimeMap(type, name).baseMapping;
    }

    /**
     * Tries to find a mapping in this injectors IMapper.  Where a object not
     * a class is provided, a instance provider mapping will be provided
     *
     * @param object or class to inject
     * @param name of mapping
     * @return the mapping where on exists
     */
    private function findMapping(object:Object, name:String = ""):IMapping
    {
      if (object is Class)
      {
        return mapper.getMapping(getClass(object), name);
      }
      return new Mapping(getClass(object), name,
              new InstanceProvider(object, applicationDomain));
    }

    private function getClass(object:Object):Class
    {
      if (object is Class)
      {
        return object as Class;
      }
      else
      {
        return applicationDomain.getDefinition(getQualifiedClassName(object)) as Class;
      }
    }

    /**
     * @private
     */
    public function get dependencyFactory():DependencyFactory
    {
      if (!_dependencyFactory)
      {
        _dependencyFactory = new DependencyFactory(detailsFactory);
      }
      return _dependencyFactory;
    }

    /**
     * @private
     */
    public function get injectionPointFactory():InjectionPointFactory
    {
      if (!_injectionPointFactory)
      {
        _injectionPointFactory =
                new InjectionPointFactory(dependencyFactory, mapper);
      }
      return _injectionPointFactory;
    }

    /**
     * @inheritDoc
     */
    public function get parent():IInjector
    {
      return _parent;
    }

    /**
     * @inheritDoc
     */
    public function hasMapping(type:Class, name:String = ""):Boolean
    {
      var thisHasMapping:Boolean = mapper.hasMapping(type, name);
      if (parent && !thisHasMapping)
      {
        return parent.hasMapping(type, name);
      }
      return thisHasMapping;
    }

    /**
     * @inheritDoc
     */
    public function removeMapping(type:Class, name:String = ""):void
    {
      mapper.removeFor(type, name);
    }

    /**
     * @inheritDoc
     */
    public function get mapper():IMapper
    {
      return _mapper;
    }

    /**
     * @inheritDoc
     */
    public function get applicationDomain():ApplicationDomain
    {
      return _applicationDomain || ApplicationDomain.currentDomain;
    }
  }
}