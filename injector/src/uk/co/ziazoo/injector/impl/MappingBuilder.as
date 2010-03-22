package uk.co.ziazoo.injector.impl
{	
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;
  import uk.co.ziazoo.injector.IMapper;
  
  internal class MappingBuilder implements IMappingBuilder
  {
    private var clazz:Class;
    private var _mapping:IMapping;
    private var reflector:Reflector;
    private var mapper:IMapper;
    
    public function MappingBuilder( clazz:Class, reflector:Reflector, mapper:IMapper )
    {
      this.clazz = clazz;
      this.reflector = reflector;
      this.mapper = mapper;
    }
    
    public function to( type:Class ):IMappingBuilder
    {
      mapping.provider = new BasicProvider( type );	
      return this;
    }
    
    public function toFactory( factory:Class ):IMappingBuilder
    {
      mapping.provider = new FactoryProvider( factory, reflector );
      asSingleton();
      return this;
    }
    
    public function toInstance( object:Object ):IMappingBuilder
    {
      mapping.provider = new InstanceProvider( object );
      asSingleton();
      return this;
    }
    
    public function named( name:String ):IMappingBuilder
    {
      mapping.name = name;
      return this;
    }
    
    public function inScope(scope:IScope):void
    {
      var provider:IProvider = mapping.provider;
      mapping.provider = new ScopeWrapper( scope.wrap(provider), provider );
    }
    
    public function asSingleton():void
    {
      inScope(new SingletonScope());
    }
    
    public function asEagerSingleton():void
    {
      asSingleton();
      mapper.addToEagerQueue(mapping)
    }
    
    public function get mapping():IMapping
    {
      if( !_mapping )
      {
        _mapping = new Mapping( clazz );
      }
      return _mapping;
    }
  }
}