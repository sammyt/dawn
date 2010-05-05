package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.query.ITypeQuery;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;
  import uk.co.ziazoo.injector.InjectorError;

  internal class Dependency implements IDependency
  {
    private var instance:Object;
    private var _provider:IProvider;
    private var _injectionDetails:ITypeInjectionDetails;

    public function Dependency(provider:IProvider,
      injectionDetails:ITypeInjectionDetails)
    {
      _provider = provider;
      _injectionDetails = injectionDetails;
    }

    /**
     * @inheritDoc
     */
    public function getObject():Object
    {
      if (!instance)
      {
        try
        {
          instance = provider.getObject();
        }
        catch(error:VerifyError)
        {
          // TODO: Meaningful error message
          var injectorError:InjectorError = new InjectorError();
          throw injectorError;
        }
      }
      return instance;
    }

    /**
     * @inheritDoc
     */
    public function get provider():IProvider
    {
      return _provider;
    }

    /**
     * @inheritDoc
     */
    public function get injectionDetails():ITypeInjectionDetails
    {
      return _injectionDetails;
    }
  }
}

