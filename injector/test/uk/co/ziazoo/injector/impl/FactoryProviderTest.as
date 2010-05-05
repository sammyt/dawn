package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;

  import some.thing.Apple;
  import some.thing.AppleFactory;
  import some.thing.Engine;

  import uk.co.ziazoo.fussy.Fussy;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  public class FactoryProviderTest
  {
    public function FactoryProviderTest()
    {
    }

    [Test]
    public function createAppleWithFactory():void
    {
      var fussy:Fussy = new Fussy();
      var factory:ITypeInjectionDetailsFactory =
        new FussyTypeDetailsFactory(fussy.query());

      var provider:FactoryProvider =
        new FactoryProvider(AppleFactory, factory.forType(AppleFactory));

      var dep:IDependency = new MockDependency(new Engine());
      provider.setDependencies([dep]);

      var apple:Apple = provider.getObject() as Apple;
      Assert.assertNotNull(apple);

      var appleFactory:AppleFactory = provider.factory as AppleFactory;
      Assert.assertNotNull(appleFactory);
      Assert.assertNotNull(appleFactory.engine);
    }
  }
}