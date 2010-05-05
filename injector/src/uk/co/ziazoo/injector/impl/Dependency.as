package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IInjectionPoint;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.InjectorError;

  internal class Dependency implements IDependency
  {
    private var mapping:IMapping;
    private var injectionPoint:IInjectionPoint;
    private var _parameterIndex:int;
    private var instance:Object;

    public function Dependency(mapping:IMapping,
      injectionPoint:IInjectionPoint = null)
    {
      this.mapping = mapping;
      _parameterIndex = 0;
      if (injectionPoint)
      {
        this.injectionPoint = injectionPoint;
      }
    }

    public function getObject():Object
    {
      if (!instance)
      {
        try
        {
          instance = getProvider().getObject();
        }
        catch(error:VerifyError)
        {
          /*
           TODO: Meaningful error message

           If the mapping is just-in-time explain that the mapping was dawns
           attempt to auto map or {type} and {name}

           If its not a just-in-time mapping they must
           have mapped it incorrectly
           */

          var injectorError:InjectorError = new InjectorError();
          throw injectorError;
        }
      }
      return instance;
    }

    public function getMapping():IMapping
    {
      return mapping;
    }

    public function getProvider():IProvider
    {
      return mapping.provider;
    }

    public function getParent():IInjectionPoint
    {
      return injectionPoint;
    }

    public function get parameterIndex():int
    {
      return _parameterIndex;
    }

    public function set parameterIndex(value:int):void
    {
      _parameterIndex = value;
    }
  }
}

