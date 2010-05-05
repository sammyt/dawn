package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;

  import some.otherthing.MoterBike;
  import some.otherthing.SlowBikeEngine;
  import some.thing.Apple;

  import uk.co.ziazoo.injector.IDependency;

  public class BasicProviderTest
  {
    public function BasicProviderTest()
    {
    }

    [Test]
    public function createsObject():void
    {
      var provider:BasicProvider = new BasicProvider(Apple);

      var apple:Apple = provider.getObject() as Apple;

      Assert.assertNotNull(apple);
    }

    [Test]
    public function createObjectWithConstructorArgs():void
    {
      var provider:BasicProvider = new BasicProvider(MoterBike);
      var dep:IDependency = new MockDependency(new SlowBikeEngine());
      provider.setDependencies([dep]);
      var bike:MoterBike = provider.getObject() as MoterBike;
      Assert.assertNotNull(bike);
    }
  }
}