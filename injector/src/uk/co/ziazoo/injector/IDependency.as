package uk.co.ziazoo.injector
{
  public interface IDependency
  {
    /**
     * Provider used to create object
     * @return IProvider for this dependency
     */
    function get provider():IProvider;

    /**
     * Gets the object from the provider
     * @return object from dependency
     */
    function getObject():Object;

    function get finalArtifact():Object;

    /**
     * Returns the ITypeInjectionDetails instance for this
     * dependencies type.  Used to get things like the injectable methods
     * @return a ITypeInjectionDetails object
     */
    function get injectionDetails():ITypeInjectionDetails;
  }
}

