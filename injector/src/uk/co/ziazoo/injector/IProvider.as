package uk.co.ziazoo.injector
{
  /**
   * IProvider instances are responsible for providing the instance of an
   * object to be injected
   */
  public interface IProvider
  {
    /**
     * The type this IProvider will provider
     * @return the class for the type of object that will be provided
     */
    function get type():Class;

    /**
     * Some objects have dependencies that need to be created before this
     * type can be, the are those injected via the constructor.  They are set
     * here so the object can be created with its dependencies described in
     * its constructor
     *
     * @param dependencies for this type (IDependency's)
     */
    function setDependencies(dependencies:Array):void;

    /**
     * Before injecting the object the injector will check that it is
     * required by looking to this property
     *
     * @return true if this object need some injection
     */
    function get requiresInjection():Boolean;

    /**
     * Once the object has been created this will return true.  If the instance
     * was provided in the mapping this will be true from the start
     * @return does the object exist
     */
    function get instanceCreated():Boolean;

    /**
     * Gets the object which should be used for injection
     * @return the object to inject into
     */
    function getInjectableObject():Object;

    /**
     * The final object to return to the user
     */
    function get finalArtifact():Object;

    /**
     * Is the finalArtifact the same object as the injectable object
     */
    function get proxiedArtifact():Boolean;
  }
}