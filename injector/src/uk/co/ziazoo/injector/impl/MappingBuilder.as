package uk.co.ziazoo.injector.impl
{	
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;
  
  internal class MappingBuilder implements IMappingBuilder
  {
    private var reflector:Reflector;
    private var mapper:IMapper;
    private var _mappings:Array;
    
    public function MappingBuilder(type:Class, reflector:Reflector, mapper:IMapper)
    {
      this.reflector = reflector;
      this.mapper = mapper;
      mappings.push(new Mapping(type));
    }
    
    public function to(type:Class):IMappingBuilder
    {
      setProvider(new BasicProvider(type));	
      return this;
    }
    
    public function and(type:Class):IMappingBuilder
    {
      var builder:IMappingBuilder = mapper.map(type);
      
      var mapping:IMapping = builder.mapping;
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
    
    public function get mapping():IMapping
    {
      return getFirstMapping();
    }
    
    internal function get mappings():Array
    {
      if(!_mappings)
      {
        _mappings = [];
      }
      return _mappings;
    }
  }
}