package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.InstanceCreator;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;

  /**
   * FactoryProvider's use custom user code to create objects.  The factorys
   * can have dependencies of their own
   */
  internal class FactoryProvider implements IProvider
  {
    /**
     * @private
     * the factory object used to create instances
     */
    internal var factory:Object;

    private var factoryType:Class;
    private var parameters:Array;
    private var details:ITypeInjectionDetails;

    /**
     * Creates a FactoryProvider for a custom user class
     * @param factoryType the class used to create instance of the type that
     * is injected
     * @param details the ITypeInjectionDetails for the factoryType class
     */
    public function FactoryProvider(factoryType:Class,
            details:ITypeInjectionDetails)
    {
      this.factoryType = factoryType;
      this.details = details;
    }

    /**
     * @inheritDoc
     */
    public function get type():Class
    {
      return factoryType;
    }

    /**
     * @inheritDoc
     */
    public function getInjectableObject():Object
    {
      if (!factory)
      {
        factory = InstanceCreator.create(factoryType, parameters);
      }
      return factory;
    }

    /**
     * @inheritDoc
     */
    public function get requiresInjection():Boolean
    {
      return true;
    }

    /**
     * @inheritDoc
     */
    public function get instanceCreated():Boolean
    {
      return true;
    }

    /**
     * @inheritDoc
     */
    public function setDependencies(dependencies:Array):void
    {
      parameters = [];
      for each(var dependency:IDependency in dependencies)
      {
        parameters.push(dependency.finalArtifact);
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

    public function get finalArtifact():Object
    {
      if (!factory)
      {
        factory = getInjectableObject();
      }
      return invokeFactoryMethod();
    }

    public function get proxiedArtifact():Boolean
    {
      return true;
    }
  }
}