package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;

  class MappingBuilder implements IMappingBuilder
  {
    private var reflector:Reflector;
    private var mapper:IMapper;
    private var mappings:Array;

    public function MappingBuilder(type:Class, reflector:Reflector, mapper:IMapper)
    {
      this.reflector = reflector;
      this.mapper = mapper;
      getMappings().push(new Mapping(type));
      to(type);
    }

    public function to(type:Class):IMappingBuilder
    {
      setProvider(new BasicProvider(type));
      return this;
    }

    public function and(type:Class):IMappingBuilder
    {
      var mapping:IMapping = new Mapping(type);
      mapping.name = getFirstMapping().name;
      mapping.provider = getFirstProvider();

      mappings.push(mapping);

      return this;
    }

    public function toFactory(factory:Class):IMappingBuilder
    {
      setProvider(new FactoryProvider(factory, reflector));
      return this;
    }

    public function toInstance(object:Object):IMappingBuilder
    {
      setProvider(new InstanceProvider(object));
      asSingleton();
      return this;
    }

    public function named(name:String):IMappingBuilder
    {
      setName(name);
      return this;
    }

    public function inScope(scope:IScope):void
    {
      var provider:IProvider = getFirstProvider();
      setProvider(new ScopeWrapper(scope.wrap(provider), provider));
    }

    public function asSingleton():void
    {
      inScope(new SingletonScope());
    }

    private function setName(name:String):void
    {
      for each(var mapping:IMapping in mappings)
      {
        mapping.name = name;
      }
    }

    private function setProvider(provider:IProvider):void
    {
      for each(var mapping:IMapping in mappings)
      {
        mapping.provider = provider;
      }
    }

    public function asEagerSingleton():void
    {
      asSingleton();
      mapper.addToEagerQueue(getFirstMapping());
    }

    private function getFirstProvider():IProvider
    {
      return getFirstMapping().provider;
    }

    internal function getFirstMapping():IMapping
    {
      return (mappings[0] as IMapping);
    }

    public function getMappings():Array
    {
      if (!mappings)
      {
        mappings = [];
      }
      return mappings;
    }

    public function get baseMapping():IMapping
    {
      return getFirstMapping();
    }
  }
}