package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IDependencyFactory;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  internal class DependencyFactory implements IDependencyFactory
  {
    private var factory:ITypeInjectionDetailsFactory;

    public function DependencyFactory(factory:ITypeInjectionDetailsFactory)
    {
      this.factory = factory;
    }

    public function forProvider(provider:IProvider):IDependency
    {
      return new Dependency(provider, factory.forType(provider.type));
    }
  }
}