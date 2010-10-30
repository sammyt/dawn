package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;

  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;

  public class MockMapper implements IMapper
  {
    public function MockMapper()
    {
    }

    public function map(type:Class):IMappingBuilder
    {
      return null;
    }

    public function getMapping(type:Class, name:String = ""):IMapping
    {
      return null;
    }

    public function getMappingForQName(qName:String, name:String = ""):IMapping
    {
      return null;
    }

    public function hasMapping(type:Class, name:String = ""):Boolean
    {
      return false;
    }

    public function add(mapping:IMapping):void
    {
    }

    public function remove(mapping:IMapping):void
    {
    }

    public function removeFor(type:Class, name:String = ""):void
    {
    }

    public function justInTimeMap(type:Class, name:String = ""):IMappingBuilder
    {
      return null;
    }

    public function justInTimeMapByQName(qName:String, name:String = ""):IMappingBuilder
    {
      return null;
    }

    public function get applicationDomain():ApplicationDomain
    {
      return null;
    }
  }
}