package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.InstanceCreator;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IProvider;

  /**
   * Basic providers are the most common provider, they are used to create
   * instances of mapped classes
   */
  internal class BasicProvider implements IProvider
  {
    private var _type:Class;
    private var parameters:Array;

    /**
     * Creates a BasicProvider for a given type
     * @param type to be created
     */
    public function BasicProvider(type:Class)
    {
      _type = type;
    }

    /**
     * @inheritDoc
     */
    public function getInjectableObject():Object
    {
      return InstanceCreator.create(_type, parameters);
    }

    /**
     * @inheritDoc
     */
    public function setDependencies(dependencies:Array):void
    {
      parameters = [];
      for each(var dependency:IDependency in dependencies)
      {
        parameters[dependency.parameterIndex - 1] = dependency.finalArtifact;
      }
    }

    /**
     * @inheritDoc
     */
    public function get type():Class
    {
      return _type;
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
      return false;
    }

    public function get finalArtifact():Object
    {
      return getInjectableObject();
    }

    public function get proxiedArtifact():Boolean
    {
      return false;
    }
  }
}

