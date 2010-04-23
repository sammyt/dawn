package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.*;

  internal class InstanceMethodInjector implements IInstanceInjector
  {
    private var methodName:String;
    private var dependencies:Array;

    public function InstanceMethodInjector(methodName:String, dependencies:Array)
    {
      this.methodName = methodName;
      this.dependencies = dependencies;
    }

    public function inject(instance:Object):void
    {
      sortDependencies();

      var args:Array = [];

      for each(var dependency:IDependency in dependencies)
      {
        args.push(dependency.getObject());
      }

      var fnt:Function = instance[ methodName ] as Function;

      fnt.apply(instance, args);
    }

    internal function sortDependencies():void
    {
      dependencies.sort(sortOnIndex);
    }

    private function sortOnIndex(a:IDependency, b:IDependency):Number
    {
      if (a.parameterIndex > b.parameterIndex)
      {
        return 1;
      }
      else if (a.parameterIndex < b.parameterIndex)
      {
        return -1;
      }
      return 0;
    }
  }
}

