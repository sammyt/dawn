package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;

  import some.thing.Tree;

  public class ReflectorTest
  {
    public function ReflectorTest()
    {
    }

    [Test]
    public function getsInjectables():void
    {
      var reflector:Reflector = new Reflector();
      var reflection:Reflection = reflector.getReflection(Tree);

      Assert.assertTrue("has 1 method", reflection.methods.length == 1);
      Assert.assertTrue("has 2 props", reflection.properties.length == 2);
      Assert.assertNotNull("has constructor", reflection.constructor);
    }
  }
}

