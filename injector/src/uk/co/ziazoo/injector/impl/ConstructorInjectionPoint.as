package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.*;

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