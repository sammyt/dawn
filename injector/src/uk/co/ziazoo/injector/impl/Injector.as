package uk.co.ziazoo.injector.impl
{
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;

  import uk.co.ziazoo.fussy.Fussy;
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

    private var mapper:IMapperList;
    private var eagerQueue:IEagerQueue;
    private var detailsFactory:ITypeInjectionDetailsFactory;
    private var _parent:IInjector;

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
      detailsFactory:ITypeInjectionDetailsFactory, parent:IInjector = null)
    {
      this.eagerQueue = eagerQueue;
      this.mapper = new MapperList(mapper);
      this.detailsFactory = detailsFactory;
      _parent = parent;
    }

    /**
     * Creates in instance of IInjector
     * @param configuration to be installed into new injector (optional)
     * @return new injector instance
     */
    public static function createInjector(
      configuration:IConfiguration = null):IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();

      var detailsFactory:ITypeInjectionDetailsFactory =
        new FussyTypeDetailsFactory(new Fussy().query());

      var mapper:IMapper = new Mapper(
        new MappingBuilderFactory(eagerQueue, detailsFactory));

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
      mapper.injectionComplete();
      return result;
    }

    private function injectMapping(mapping:IMapping):Object
    {
      var dependency:IDependency =
        dependencyFactory.forProvider(mapping.provider);

      return create(dependency).getObject();
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
          provider.withDependencies(injectionPoint.getDependencies());
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

      for each(var injectionPoint:PropertyInjectionPoint in injectionPoints)
      {
        for each(var child:IDependency in injectionPoint.getDependencies())
        {
          var instance:Object = dependency.getObject();
          injectionPoint.property.setter(instance, create(child).getObject());
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
          args.push(create(child).getObject());
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
    public function installPrivate(
      configuration:IPrivateConfiguration):IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();

      var privateMapper:IPrivateMapper = new PrivateMapper(
        new MappingBuilderFactory(eagerQueue, detailsFactory), mapper);

      configuration.configure(privateMapper);

      return new Injector(privateMapper, eagerQueue, detailsFactory, this);
    }


    /**
     * @inheritDoc
     */
    public function createChildInjector():IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();
      var childMapper:IMapper = new Mapper(
        new MappingBuilderFactory(eagerQueue, detailsFactory));

      return new Injector(childMapper, eagerQueue, detailsFactory, this);
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
      return new Mapping(getClass(object), name, new InstanceProvider(object));
    }

    private function getClass(object:Object):Class
    {
      if (object is Class)
      {
        return object as Class;
      }
      else
      {
        return getDefinitionByName(getQualifiedClassName(object)) as Class;
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
        _injectionPointFactory = new InjectionPointFactory(dependencyFactory, mapper);
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
  }
}