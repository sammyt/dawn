package uk.co.ziazoo.injector.impl
{
  import flash.utils.Dictionary;
  import flash.utils.getDefinitionByName;

  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;

  internal class Mapper implements IMapper
  {
    private var typesMap:Dictionary;
    private var eagers:Array;
    private var reflector:Reflector;
    
    public function Mapper(reflector:Reflector)
    {
      typesMap = new Dictionary();
      this.reflector = reflector;
    }

    /**
     * @inheritDoc
     */
    public function map(type:Class):IMappingBuilder
    {
      var builder:IMappingBuilder = new MappingBuilder(type, reflector, this);
      addMapping(type, builder.mapping);
      return builder;
    }

    /**
     * Adds a mappings into the mappings dictionary
     *
     * @param type Class whos mapping this is
     * @param mapping to store
     */
    private function addMapping(type:Class, mapping:IMapping):void
    {
      var mappings:Array = getMappingsForType(type);
      mappings.push(mapping);
    }

    /**
     * Gets the array of mappings for the type provider
     * 
     * @param type who's mappings you want
     * @return array of mappings for type
     */
    private function getMappingsForType(type:Class):Array
    {
      var mappings:Array = typesMap[type];
      if(!mappings)
      {
        mappings = typesMap[type] = [];
      }
      return mappings;
    }

    /**
     * Finds a mapping with a given name within a list of mappings
     *
     * @param name for the mapping to find
     * @param mappings array to search within
     * @return the IMapping, else null
     */
    private function findMappingForName(
      mappings:Array, name:String = ""):IMapping
    {
      for each(var mapping:IMapping in mappings)
      {
        if(mapping.name == name)
        {
          return mapping;
        }
      }
      return null;
    }

    /**
     * @inheritDoc
     */
    public function getMapping(type:Class, name:String = ""):IMapping
    {
      return findMappingForName(getMappingsForType(type), name);
    }

    /**
     * @inheritDoc
     */
    public function getMappingForQName(
      qName:String, name:String = ""):IMapping
    {
      var type:Class = getDefinitionByName(qName) as Class;
      return getMapping(type, name);
    }

    /**
     * @inheritDoc
     */
    public function addToEagerQueue(mapping:IMapping):void
    {
      if(!eagers)
      {
        eagers = [];
      }
      eagers.push(mapping);
    }

    /**
     * @inheritDoc
     */
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

    /**
     * @inheritDoc
     */
    public function hasMapping(type:Class, name:String = ""):Boolean
    {
      return getMapping(type, name) != null;
    }

    /**
     * @inheritDoc
     */
    public function add(mapping:IMapping):void
    {
      addMapping(mapping.type, mapping);
    }

    /**
     * @inheritDoc
     */
    public function remove(mapping:IMapping):void
    {
      removeFor(mapping.type, mapping.name);
    }

    /**
     * @inheritDoc
     */
    public function removeFor(type:Class, name:String = ""):void
    {
      var mappings:Array = getMappingsForType(type);
      typesMap[type] = mappings.filter(
        function(mapping:IMapping):Boolean
        {
          return mapping.name != name;
        });
    }

    /**
     * @inheritDoc
     */
    public function justInTimeMap(type:Class):IMappingBuilder
    {
      return null;
    }

    /**
     * @inheritDoc
     */
    public function newBuilder(type:Class):IMappingBuilder
    {
      return new MappingBuilder(type, reflector, this);
    }
  }
}