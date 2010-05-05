package uk.co.ziazoo.injector
{
  import uk.co.ziazoo.fussy.model.Constructor;
  import uk.co.ziazoo.fussy.model.Method;

  public interface ITypeInjectionDetails
  {
    /**
     * List of all injectable properties
     * @return Array of <code>Property</code> objects
     */
    function get properties():Array;

    /**
     * List of injectable methods
     * @return Array of <code>Method</code> objects
     */
    function get methods():Array;

    /**
     * An injectable constructor for the type.  If the constructor
     * of the type is not injectable (no parameters) then this
     * property will ne null
     * @return the <code>Constructor</code>
     */
    function get constructor():Constructor;

    /**
     * Metadata for type
     * @return array of Metadata objects
     */
    function get metadata():Array;

    /**
     * A <code>Method</code> object descriping the [PostConstruct]
     * method of a type, or null if there is none
     * @return a Method object for the post construction callback
     */
    function get postConstructMethod():Method;

    /**
     * If this type is a factory object it will have a provider
     * method, else this will be null
     * @return a Method object for the provider method
     */
    function get providerMethod():Method;
  }
}