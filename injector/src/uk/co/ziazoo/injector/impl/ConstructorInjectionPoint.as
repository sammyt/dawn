package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.model.Constructor;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IInjectionPoint;

  internal class ConstructorInjectionPoint implements IInjectionPoint
  {
    private var constructor:Constructor;
    private var dependencies:Array;

    public function ConstructorInjectionPoint(constructor:Constructor)
    {
      this.constructor = constructor;
      dependencies = [];
    }

    public function getDependencies():Array
    {
      return dependencies;
    }

    internal function addDependency(dependency:IDependency):void
    {
      dependencies.push(dependency);
    }
  }
}