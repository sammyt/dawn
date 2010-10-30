package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;

  import org.flexunit.Assert;

  import some.thing.Apple;
  import some.thing.Car;
  import some.thing.IRadio;
  import some.thing.LoudRadio;

  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;

  public class MappingBuilderTest
  {
    private var builder:MappingBuilder;

    public function MappingBuilderTest()
    {
    }

    [Before]
    public function setUp():void
    {
      builder = new MappingBuilder(Apple, new EagerQueue(),
              null, ApplicationDomain.currentDomain);
    }

    [After]
    public function tearDown():void
    {
      builder = null;
    }

    [Test]
    public function createMapping():void
    {
      builder.to(Car);
      var mapping:IMapping = builder.baseMapping;
      Assert.assertTrue("maps correct class", mapping.type == Apple);
      Assert.assertTrue("provider of correct type",
              mapping.provider is BasicProvider);

      var provider:BasicProvider = BasicProvider(mapping.provider);
      Assert.assertTrue("provider for Car", provider.type == Car);
    }

    [Test]
    public function createMappingWithName():void
    {
      builder.to(Car).named("car tree?");

      var mapping:IMapping = builder.baseMapping;
      Assert.assertTrue("maps correct class", mapping.type == Apple);
      Assert.assertTrue("provider of correct type",
              mapping.provider is BasicProvider);

      var provider:BasicProvider = BasicProvider(mapping.provider);
      Assert.assertTrue("provider for Car", provider.type == Car);

      Assert.assertTrue("gets the name right", mapping.name == "car tree?");
    }

    [Test]
    public function testMultiMapping():void
    {
      builder.to(IRadio).and(LoudRadio);

      var mappings:Array = builder.getMappings();

      Assert.assertTrue("two mappings", mappings.length == 2);

      var provider:IProvider = builder.baseMapping.provider;

      for each(var mapping:IMapping in mappings) {
        Assert.assertTrue("both mapped to same provider",
                provider == mapping.provider);
      }
    }

    [Test]
    public function testMultiMappingScope():void
    {
      builder.to(IRadio).and(LoudRadio).asSingleton();

      var mappings:Array = builder.getMappings();

      Assert.assertTrue("two mappings", mappings.length == 2);

      var provider:IProvider = builder.baseMapping.provider;

      for each(var mapping:IMapping in mappings) {
        Assert.assertTrue("both mapped to same singleton provider",
                provider == mapping.provider);
      }
    }
  }
}