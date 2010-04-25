package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;

  import some.thing.BigEngine;
  import some.thing.Car;
  import some.thing.Engine;
  import some.thing.Table;

  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;

  public class MapperListTest
  {
    private var mapperList:MapperList;
    private var mapper:IMapper;

    public function MapperListTest()
    {
    }

    [Before]
    public function setUp():void
    {
      mapper = createMapper();

      mapperList = new MapperList(mapper);
    }

    [After]
    public function tearDown():void
    {
      mapperList = null;
    }

    private function createMapper():IMapper
    {
      return new Mapper(new MappingBuilderFactory(
        new Reflector(), new EagerQueue()));
    }

    [Test]
    public function getMapping():void
    {
      mapper.map(Car).toInstance(new Car());
      Assert.assertNotNull(mapperList.getMapping(Car));
    }

    [Test]
    public function hasMapping():void
    {
      Assert.assertFalse(mapperList.hasMapping(Car));
      mapper.map(Car).toInstance(new Car());
      Assert.assertTrue(mapperList.hasMapping(Car));
    }

    [Test]
    public function mapThings():void
    {
      Assert.assertNotNull(mapperList.map(Table));
      Assert.assertTrue(mapperList.map(Car) is IMappingBuilder);
      Assert.assertTrue(mapperList.hasMapping(Table));
    }

    [Test]
    public function getForQName():void
    {
      mapper.map(Car);
      Assert.assertNotNull(mapperList.getMappingForQName("some.thing::Car"));
    }

    [Test]
    public function addingAChildMapper():void
    {
      var child:IMapper = createMapper();
      child.map(Engine).to(BigEngine).named("Big");

      mapper.map(Engine);

      mapperList.expose(Engine, "Big", child);

      var notUsingExposedMapping:IMapping = mapperList.getMapping(Engine);
      Assert.assertTrue(notUsingExposedMapping.provider.type == Engine);

      var usingExposedMapping:IMapping = mapperList.getMapping(Engine, "Big");
      Assert.assertTrue(usingExposedMapping.provider.type == BigEngine);
    }
  }
}
