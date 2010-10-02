package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.Fussy;

  public class InjectionPointFactoryTest
  {
    private var factory:InjectionPointFactory;

    public function InjectionPointFactoryTest()
    {
    }

    [Before]
    public function setUp():void
    {
      factory = new InjectionPointFactory(
        new MockNullDependencyFactory(), new MockMapper());
    }

    [After]
    public function tearDown():void
    {
      factory = null;
    }

    [Test]
    public function createPropertyInjectionPoints():void
    {
      
    }
  }
}