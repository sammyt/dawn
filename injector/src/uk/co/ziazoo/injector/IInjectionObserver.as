package uk.co.ziazoo.injector
{	
  /**
   *	<code>IInjectionObserver</code> is used to observe the 
   *	construction process of the dependencies of a <code>IInjectionPoint</code>
   */	
  public interface IInjectionObserver
  {
    /**
     *	Called when a dependency is resolved
     */	
    function onDependencyResolved( dependency:IDependency ):void;
  }
}