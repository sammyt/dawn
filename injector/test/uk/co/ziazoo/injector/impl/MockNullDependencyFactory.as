package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IDependencyFactory;
  import uk.co.ziazoo.injector.IProvider;

  public class MockNullDependencyFactory implements IDependencyFactory
  {
    public function MockNullDependencyFactory()
    {
    }

    public function forProvider(provider:IProvider):IDependency
    {
      return null;
    }
  }
}