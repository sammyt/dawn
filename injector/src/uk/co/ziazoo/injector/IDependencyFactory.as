package uk.co.ziazoo.injector
{
  public interface IDependencyFactory
  {
    function forProvider(provider:IProvider):IDependency;
  }
}