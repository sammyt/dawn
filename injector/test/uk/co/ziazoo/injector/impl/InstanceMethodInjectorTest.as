package uk.co.ziazoo.injector.impl
{
  import org.flexunit.*;

  import some.thing.*;

  public class InstanceMethodInjectorTest
  {
    public function InstanceMethodInjectorTest()
    {
    }

    [Test]
    public function doesItInject():void
    {
      var dependencies:Array = [ new MockDependency(new Leaf()) ];

      var injector:InstanceMethodInjector =
        new InstanceMethodInjector("injectLeaf", dependencies);

      var tree:Tree = new Tree(null);
      injector.inject(tree);
      Assert.assertNotNull("has a leaf", tree.leaf);
    }

    [Test]
    public function injectSeveralParamsUnordered():void
    {
      var dependencies:Array = [
        new MockDependency(new Apple(), 2),
        new MockDependency(new Engine(), 1),
        new MockDependency(new Car(), 3) ];

      var injector:InstanceMethodInjector =
        new InstanceMethodInjector("setThings", dependencies);

      var ground:Ground = new Ground();
      injector.inject(ground);

      Assert.assertNotNull("has a engine", ground.engine);
      Assert.assertNotNull("has a apple", ground.apple);
      Assert.assertNotNull("has a car", ground.car);
    }
  }
}