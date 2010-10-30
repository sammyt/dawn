package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;
  import flash.utils.Dictionary;

  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IMappingBuilderFactory;

  internal class Mapper implements IMapper
  {
    /**
     * array of builders with mappings that have not yet
     * been added to the typesMap
     */
    private var builders:Array;

    /**
     * map of mappings [Class][String]
     */
    private var mappings:Dictionary;

    /**
     * used to create the mappings with the mapping DSL
     */
    private var builderFactory:IMappingBuilderFactory;
    private var _applicationDomain:ApplicationDomain;

    public function Mapper(builderFactory:IMappingBuilderFactory, applicationDomain:ApplicationDomain)
    {
      this.builderFactory = builderFactory;
      _applicationDomain = applicationDomain;
      mappings = new Dictionary();
      builders = [];
    }

    /**
     * @inheritDoc
     */
    public function map(type:Class):IMappingBuilder
    {
      var builder:IMappingBuilder = builderFactory.forType(type);
      builders.push(builder);
      return builder;
    }

    /**
     * @private
     *
     * adds any mappings in the builders array
     */
    internal function processBuilders():void
    {
      for each(var builder:IMappingBuilder in builders) {
        for each(var mapping:IMapping in builder.getMappings()) {
          add(mapping);
        }
      }
      builders = [];
    }

    /**
     * @inheritDoc
     */
    public function getMapping(type:Class, name:String = ""):IMapping
    {
      processBuilders();

      if (mappings[type]) {
        var key:String = emptyNameCheck(name);
        return mappings[type][key] as IMapping;
      }
      return null;
    }

    /**
     * @inheritDoc
     */
    public function getMappingForQName(qName:String, name:String = ""):IMapping
    {
      var type:Class = applicationDomain.getDefinition(qName) as Class;
      return getMapping(type, name);
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
      if (!mappings[mapping.type]) {
        mappings[mapping.type] = new Dictionary();
      }
      var key:String = emptyNameCheck(mapping.name);
      mappings[mapping.type][key] = mapping;
    }

    private function emptyNameCheck(name:String):String
    {
      return name == "" || !name ? "no_name" : name;
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
      if (mappings[type]) {
        var byName:Dictionary = mappings[type] as Dictionary;
        var key:String = emptyNameCheck(name);
        if (byName[key]) {
          delete byName[key];
        }
      }
    }

    /**
     * @inheritDoc
     */
    public function justInTimeMap(type:Class, name:String = ""):IMappingBuilder
    {
      var builder:IMappingBuilder = map(type).named(name);
      builder.baseMapping.isJustInTime = true;
      builders.push(builder);
      return builder;
    }

    /**
     * @inheritDoc
     */
    public function justInTimeMapByQName(qName:String, name:String = ""):IMappingBuilder
    {
      return justInTimeMap(applicationDomain.getDefinition(qName) as Class, name);
    }

    public function get applicationDomain():ApplicationDomain
    {
      return _applicationDomain;
    }
  }
}