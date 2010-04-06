package uk.co.ziazoo.injector.impl
{	
  import flash.utils.getDefinitionByName;
  
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  
  internal class Mapper implements IMapper
  {
    private var mappings:Array;
    private var eagers:Array;
    private var reflector:Reflector;
    
    public function Mapper(reflector:Reflector)
    {
      mappings = [];
      this.reflector = reflector;
    }
    
    public function map(clazz:Class):IMappingBuilder
    {
      var builder:IMappingBuilder = new MappingBuilder(clazz, reflector, this);
      mappings.push(builder.mapping);
      builder.to(clazz);
      
      return builder;
    }
    
    public function getMapping(type:Class, name:String = ""):IMapping
    {
      var unNamed:IMapping;
      for each(var mapping:IMapping in mappings)
      {
        if(mapping.type == type)
        {
          if(mapping.name == name)
          {
            return mapping;
          }
          else if(mapping.name == "")
          {
            unNamed = mapping;
          }
        }
      }
      
      if(!unNamed)
      {
        unNamed = map(type).to(type).mapping;
      }
      return unNamed;
    }
    
    public function getMappingFromQName(
      qName:String, name:String = ""):IMapping
    {
      var type:Class = getDefinitionByName(qName) as Class;
      return getMapping(type, name);
    }
    
    public function addToEagerQueue(mapping:IMapping):void
    {
      if(!eagers)
      {
        eagers = [];
      }
      eagers.push(mapping);
    }
    
    public function getEagerQueue():Array
    {
      var queue:Array = [];
      for each(var mapping:IMapping in eagers)
      {
        queue.push(mapping);
      }
      eagers = [];
      return queue;
    }
  }
}