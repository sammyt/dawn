package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.InstanceCreator;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;

  internal class FactoryProvider implements IProvider
  {
    private var factoryType:Class;
    private var params:Array;
    private var factory:Object;
    private var details:ITypeInjectionDetails;

    public function FactoryProvider(factoryType:Class,
      details:ITypeInjectionDetails)
    {
      this.factoryType = factoryType;
      this.details = details;
    }

    public function get type():Class
    {
      return factoryType;
    }

    public function getObject():Object
    {
      if (!factory)
      {
        factory = InstanceCreator.create(factoryType, params);
      }
      return invokeFactoryMethod();
    }

    public function get requiresInjection():Boolean
    {
      return true;
    }

    public function get instanceCreated():Boolean
    {
      return true;
    }

    public function setDependencies(dependencies:Array):void
    {
      params = [];
      for each(var dependency:IDependency in dependencies)
      {
        params.push(dependency.getObject());
      }
    }

    internal function invokeFactoryMethod():Object
    {
      var provider:Function = factory[ getMethodName() ] as Function;
      return provider.apply(factory);
    }

    private function getMethodName():String
    {
      return details.providerMethod.name;
    }
  }
}