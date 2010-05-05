package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.model.Constructor;
  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;

  public class TypeInjectionDetails implements ITypeInjectionDetails
  {
    private var _providerMethod:Method;
    private var _postConstruct:Method;
    private var _constructor:Constructor;
    private var _methods:Array;
    private var _properties:Array;
    private var _metadata:Array;

    public function TypeInjectionDetails(properties:Array, methods:Array,
      constructor:Constructor, postConstruct:Method, providerMethod:Method,
      metadata:Array)
    {
      _providerMethod = providerMethod;
      _postConstruct = postConstruct;
      _constructor = constructor;
      _methods = methods;
      _properties = properties;
      _metadata = metadata;
    }

    /**
     * @inheritDoc
     */
    public function get properties():Array
    {
      return _properties;
    }

    /**
     * @inheritDoc
     */
    public function get methods():Array
    {
      return _methods;
    }

    /**
     * @inheritDoc
     */
    public function get constructor():Constructor
    {
      return _constructor;
    }

    /**
     * @inheritDoc
     */
    public function get postConstructMethod():Method
    {
      return _postConstruct;
    }

    /**
     * @inheritDoc
     */
    public function get providerMethod():Method
    {
      return _providerMethod;
    }

    public function get metadata():Array
    {
      return _metadata;
    }
  }
}