package uk.co.ziazoo.injector.impl
{
  import org.flexunit.*;

  import some.thing.*;

  import uk.co.ziazoo.injector.*;

  public class MapperTest
  {
    private var mapper:Mapper;

    public function MapperTest()
    {
    }

    [Before]
    public function setUp():void
    {
      mapper = new Mapper(new MappingBuilderFactory(null, null));
    }

    [After]
    public function tearDown():void
    {
      mapper = null;
    }

    [Test]
    public function mapReturnsCorrectMapping():void
    {
      mapper.map(Car).to(CarWithTwoRadios);
      var mapping:IMapping = mapper.getMapping(Car);
      Assert.assertTrue("correct type for DSL", mapping.type == Car);
      Assert.assertTrue("correct name for DSL", mapping.name == "");
    }

    [Test]
    public function getsCorrectMapByName():void
    {
      mapper.map(Car).to(CarWithTwoRadios);
      mapper.map(Car).to(CarWithOneRadio).named("one");
      var noName:IMapping = mapper.getMapping(Car);
      var named:IMapping = mapper.getMapping(Car, "one");

      Assert.assertTrue("correct type for DSL", noName.type == Car);
      Assert.assertTrue("correct name for DSL", noName.name == "");

      Assert.assertTrue("correct type for DSL", named.type == Car);
      Assert.assertTrue("correct name for DSL", named.name == "one");

      Assert.assertNull("there is no car two", mapper.getMapping(Car, "two"));
    }

    [Test]
    public function hasMapping():void
    {
      mapper.add(new MockMapping(Car, "wibble"));

      Assert.assertTrue("it has the mapping", mapper.hasMapping(Car, "wibble"));
      Assert.assertFalse(mapper.hasMapping(Car, "no no no"));
    }

    [Test]
    public function getByQName():void
    {
      mapper.add(new MockMapping(Car));
      Assert.assertNotNull(mapper.getMappingForQName("some.thing::Car"));
    }

    [Test]
    public function canRemoveByReference():void
    {
      var car:IMapping = new MockMapping(Car);
      var tree:IMapping = new MockMapping(Tree);
      var pine:IMapping = new MockMapping(Tree, "pine");
      var apple:IMapping = new MockMapping(Tree, "apple");
      mapper.add(pine);
      mapper.add(apple);
      mapper.add(car);
      mapper.add(tree);

      Assert.assertTrue(mapper.hasMapping(Tree, "pine"));
      Assert.assertTrue(mapper.hasMapping(Tree, "apple"));
      Assert.assertTrue(mapper.hasMapping(Tree));
      Assert.assertTrue(mapper.hasMapping(Car));

      mapper.remove(pine);

      Assert.assertFalse(mapper.hasMapping(Tree, "pine"));
      Assert.assertTrue(mapper.hasMapping(Tree, "apple"));
      Assert.assertTrue(mapper.hasMapping(Tree));
      Assert.assertTrue(mapper.hasMapping(Car));
    }


    [Test]
    public function canRemoveForNameAndType():void
    {
      var car:IMapping = new MockMapping(Car);
      var tree:IMapping = new MockMapping(Tree);
      var pine:IMapping = new MockMapping(Tree, "pine");
      var apple:IMapping = new MockMapping(Tree, "apple");
      mapper.add(pine);
      mapper.add(apple);
      mapper.add(car);
      mapper.add(tree);

      Assert.assertTrue(mapper.hasMapping(Tree, "pine"));
      Assert.assertTrue(mapper.hasMapping(Tree, "apple"));
      Assert.assertTrue(mapper.hasMapping(Tree));
      Assert.assertTrue(mapper.hasMapping(Car));

      mapper.removeFor(Tree, "pine");

      Assert.assertFalse(mapper.hasMapping(Tree, "pine"));
      Assert.assertTrue(mapper.hasMapping(Tree, "apple"));
      Assert.assertTrue(mapper.hasMapping(Tree));
      Assert.assertTrue(mapper.hasMapping(Car));
    }

    [Test]
    public function createJustInTimeMapping():void
    {
      mapper.justInTimeMap(Car).named("example");
      Assert.assertTrue(mapper.hasMapping(Car, "example"));

      var mapping:IMapping = mapper.getMapping(Car, "example");
      Assert.assertNotNull(mapping);
      Assert.assertTrue(mapping.isJustInTime);
      Assert.assertNotNull(mapping.provider);
    }
  }
}

