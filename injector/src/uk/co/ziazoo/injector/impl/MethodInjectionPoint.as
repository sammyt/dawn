package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IInjectionPoint;

  internal class MethodInjectionPoint implements IInjectionPoint
  {
    private var _method:Method;
    private var dependencies:Array;

    public function MethodInjectionPoint(method:Method)
    {
      _method = method;
      dependencies = [];
    }

    public function get method():Method
    {
      return _method;
    }

    public function getDependencies():Array
    {
      return dependencies;
    }

    public function isOptional():Boolean
    {
      return false;
    }

    internal function addDependency(dependency:IDependency):void
    {
      dependencies.push(dependency);
    }
  }
}