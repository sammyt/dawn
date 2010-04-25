package uk.co.ziazoo.injector.impl
{
  import flash.utils.getDefinitionByName;

  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;

  public class MapperList implements IMapperList
  {
    /**
     * default mapper for this list
     */
    private var mapper:IMapper;

    /**
     *  list of ExposedMapper objects for this list
     */
    private var children:Array;

    /**
     * Creates IMapperList with a base mapper of the param
     * @param mapper used by default when no other mappers are exposed
     */
    public function MapperList(mapper:IMapper)
    {
      this.mapper = mapper;
    }

    public function expose(type:Class, name:String, mapper:IMapper):void
    {
      if (!children) children = [];

      children.push(new ExposedMapper(type, name, mapper));
    }

    public function map(type:Class):IMappingBuilder
    {
      return mapper.map(type);
    }

    public function getMapping(type:Class, name:String = ""):IMapping
    {
      checkUsage(type, name);
      var mapping:IMapping;
      for each(var exposedMapper:ExposedMapper in children)
      {
        if (exposedMapper.inUse)
        {
          // does it make sense to just use the first mapper
          // which has a mapping for this key?
          mapping = exposedMapper.mapper.getMapping(type, name);
          if (mapping)
          {
            break;
          }
        }
      }
      if (!mapping)
      {
        mapping = mapper.getMapping(type, name);
      }
      return mapping;
    }

    public function getMappingForQName(qName:String, name:String = ""):IMapping
    {
      var type:Class = getDefinitionByName(qName) as Class;
      return getMapping(type, name);
    }

    public function hasMapping(type:Class, name:String = ""):Boolean
    {
      checkUsage(type, name);

      for each(var exposedMapper:ExposedMapper in children)
      {
        if (exposedMapper.inUse)
        {
          // does it make sense to just use the first mapper
          // which has a mapping for this key?
          var answer:Boolean = exposedMapper.mapper.hasMapping(type, name);
          if (answer)
          {
            return true;
          }
        }
      }
      return mapper.hasMapping(type, name);
    }

    private function checkUsage(type:Class, name:String):void
    {
      for each(var exposedMapper:ExposedMapper in children)
      {
        if (exposedMapper.exposedBy(type, name))
        {
          exposedMapper.inUse = true;
        }
      }
    }

    public function add(mapping:IMapping):void
    {
      mapper.add(mapping);
    }

    public function remove(mapping:IMapping):void
    {
      mapper.remove(mapping);
    }

    public function removeFor(type:Class, name:String = ""):void
    {
      mapper.removeFor(type, name);
    }

    public function justInTimeMap(type:Class, name:String = ""):IMappingBuilder
    {
      return mapper.justInTimeMap(type, name);
    }

    public function justInTimeMapByQName(
      qName:String, name:String = ""):IMappingBuilder
    {
      return mapper.justInTimeMapByQName(qName, name);
    }

    public function injectionComplete():void
    {
      for each(var exposedMapper:ExposedMapper in children)
      {
        exposedMapper.inUse = false;
      }
    }
  }
}

import uk.co.ziazoo.injector.IMapper;

class ExposedMapper
{
  public var inUse:Boolean = false;
  public var type:Class;
  public var name:String;
  public var mapper:IMapper;

  public function ExposedMapper(type:Class, name:String, mapper:IMapper)
  {
    this.type = type;
    this.name = name;
    this.mapper = mapper;
  }

  public function exposedBy(type:Class, name:String):Boolean
  {
    return this.type == type && this.name == name;
  }
}
