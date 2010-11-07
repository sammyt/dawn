package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.*;

  public class MockDependency implements IDependency
  {
    private var object:Object;

    public function MockDependency(object:Object)
    {
      this.object = object;
    }

    public function getObject():Object
    {
      return object;
    }

    public function get provider():IProvider
    {
      return null;
    }

    public function get injectionDetails():ITypeInjectionDetails
    {
      return null;
    }

    public function get isOptional():Boolean
    {
      return false;
    }

    public function get optedOut():Boolean
    {
      return false;
    }

    public function get finalArtifact():Object
    {
      return getObject();
    }
  }
}