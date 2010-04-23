package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;

  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IMapping;

  public class EagerQueueTest
  {
    private var queue:IEagerQueue;

    public function EagerQueueTest()
    {
    }

    [Before]
    public function setUp():void
    {
      queue = new EagerQueue();
    }

    [After]
    public function tearDown():void
    {
      queue = null;
    }

    [Test]
    public function canAdd():void
    {
      var mapping:IMapping = new MockMapping();
      queue.push(mapping);
      Assert.assertTrue(queue.length == 1);
    }

    [Test]
    public function canRemove():void
    {
      var mapping:IMapping = new MockMapping();
      queue.push(mapping);
      Assert.assertTrue(queue.length == 1);

      Assert.assertTrue(mapping == queue.pop());
      Assert.assertTrue(queue.length == 0);
    }
  }
}