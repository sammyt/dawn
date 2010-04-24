package uk.co.ziazoo.injector.impl
{
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;

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

  public class Injector implements IInjector
  {
    private var _dependencyFactory:DependencyFactory;
    private var _injectionPointFactory:InjectionPointFactory;

    private var reflector:Reflector;
    private var mapper:IMapper;
    private var eagerQueue:IEagerQueue;
    private var _parent:IInjector;

    public function Injector(mapper:IMapper, eagerQueue:IEagerQueue,
      reflector:Reflector, parent:IInjector = null)
    {
      this.reflector = reflector;
      this.eagerQueue = eagerQueue;
      this.mapper = mapper;
      _parent = parent;
    }

    public static function createInjector(
      configuration:IConfiguration = null):IInjector
    {
      var reflector:Reflector = new Reflector();
      var eagerQueue:IEagerQueue = new EagerQueue();
      var mapper:IMapper = new Mapper(
        new MappingBuilderFactory(reflector, eagerQueue));

      if (configuration)
      {
        configuration.configure(mapper);
      }

      var injector:Injector = new Injector(mapper, eagerQueue, reflector);

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
    public function inject(object:Object):Object
    {
      injectEagerQueue();

      var mapping:IMapping = findMapping(object);
      if (!mapping)
      {
        mapping = mapper.justInTimeMap(getClass(object)).baseMapping;
      }
      return injectMapping(mapping);
    }

    private function injectMapping(mapping:IMapping):Object
    {
      var dependency:IDependency = dependencyFactory.forMapping(mapping);

      return create(dependency).getObject();
    }

    private function create(dependency:IDependency):IDependency
    {
      var provider:IProvider = dependency.getProvider();
      if (!provider.requiresInjection)
      {
        return dependency;
      }

      if (!provider.instanceCreated)
      {
        var reflection:Reflection = getReflection(dependency);

        if (reflection.constructor.hasParams())
        {
          var injectionPoint:IInjectionPoint =
            injectionPointFactory.forConstructor(reflection.constructor);

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
      var reflection:Reflection = getReflection(dependency);
      if (reflection.hasCompleteMethod())
      {
        var methodName:String = reflection.completeMethod.name;

        var invoker:MethodInvoker =
          new MethodInvoker(dependency.getObject(), methodName);

        invoker.invoke();
      }
    }

    private function injectPropertyDependencies(dependency:IDependency):void
    {
      var reflection:Reflection = getReflection(dependency);

      var injectionPoints:Array = injectionPointFactory.forProperties(
        reflection.properties);

      for each(var injectionPoint:PropertyInjectionPoint in injectionPoints)
      {
        for each(var child:IDependency in injectionPoint.getDependencies())
        {
          var injector:InstancePropertyInjector = new InstancePropertyInjector(
            injectionPoint.getPropertyName(), create(child).getObject());

          injector.inject(dependency.getObject());
        }
      }
    }

    private function injectMethodDependencies(dependency:IDependency):void
    {
      var reflection:Reflection = getReflection(dependency);

      var injectionPoints:Array = injectionPointFactory.forMethods(
        reflection.methods);

      for each(var injectionPoint:MethodInjectionPoint in injectionPoints)
      {
        for each(var child:IDependency in injectionPoint.getDependencies())
        {
          create(child);
        }

        var injector:InstanceMethodInjector = new InstanceMethodInjector(
          injectionPoint.getMethodName(), injectionPoint.getDependencies());

        injector.inject(dependency.getObject());
      }
    }

    private function getReflection(dependency:IDependency):Reflection
    {
      var type:Class = dependency.getProvider().type;
      return reflector.getReflection(type);
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
        new MappingBuilderFactory(reflector, eagerQueue));

      return new Injector(privateMapper, eagerQueue, reflector, this);
    }


    /**
     * @inheritDoc
     */
    public function createChildInjector():IInjector
    {
      var eagerQueue:IEagerQueue = new EagerQueue();
      var childMapper:IMapper = new Mapper(
        new MappingBuilderFactory(reflector, eagerQueue));

      return new Injector(childMapper, eagerQueue, reflector, this);
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
        _dependencyFactory = new DependencyFactory();
      }
      return _dependencyFactory;
    }

    public function set dependencyFactory(value:DependencyFactory):void
    {
      _dependencyFactory = value;
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

    public function set injectionPointFactory(value:InjectionPointFactory):void
    {
      _injectionPointFactory = value;
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