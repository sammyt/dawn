package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IInjectionPoint;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;

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
        instance = getProvider().getObject();
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

