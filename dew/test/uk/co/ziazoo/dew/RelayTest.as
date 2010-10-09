/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08-Oct-2010
 * Time: 20:48:48
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import org.flexunit.Assert;

  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class RelayTest
  {
    public function RelayTest()
    {
    }

    [Test]
    public function relaySimpleMessage():void
    {
      var relay:IRelay = new Relay();

      var sender:INotifier = new Notifier();
      var receiver:INotifier = new Notifier();

      relay.addTransmitter(sender);
      relay.addReceiver(receiver);

      var invoked:Boolean = false;

      receiver.listen(Array, function(msg:Array):void
      {
        invoked = msg[0] == "simple";
      });

      sender.trigger(["simple"]);

      Assert.assertTrue(invoked);
    }

    [Test]
    public function relayTwice():void
    {
      var relay:IRelay = new Relay();

      var sender:INotifier = new Notifier();
      var receiver1:INotifier = new Notifier();
      var receiver2:INotifier = new Notifier();

      relay.addTransmitter(sender);
      relay.addReceiver(receiver1);
      relay.addReceiver(receiver2);

      var invoked1:Boolean = false;
      var invoked2:Boolean = false;

      receiver1.listen(Array, function(msg:Array):void
      {
        invoked1 = msg[0] == "simple";
      });

      receiver2.listen(Array, function(msg:Array):void
      {
        invoked2 = msg[0] == "simple";
      });

      sender.trigger(["simple"]);

      Assert.assertTrue(invoked1);
      Assert.assertTrue(invoked2);
    }

    [Test]
    public function removeReceiver():void
    {
      var relay:IRelay = new Relay();

      var sender:INotifier = new Notifier();
      var receiver:INotifier = new Notifier();

      relay.addTransmitter(sender);
      relay.addReceiver(receiver);

      var invokedCount:int = 0;

      receiver.listen(Array, function(msg:Array):void
      {
        invokedCount++;
      });

      sender.trigger([]);

      Assert.assertEquals(invokedCount, 1);

      relay.removeReceiver(receiver);

      sender.trigger([]);

      Assert.assertEquals(invokedCount, 1);
    }

    [Test]
    public function removeTansmitter():void
    {
      var relay:IRelay = new Relay();

      var sender:INotifier = new Notifier();
      var receiver:INotifier = new Notifier();

      relay.addTransmitter(sender);
      relay.addReceiver(receiver);

      var invokedCount:int = 0;

      receiver.listen(Array, function(msg:Array):void
      {
        invokedCount++;
      });

      sender.trigger([]);

      Assert.assertEquals(invokedCount, 1);
      sender.trigger([]);
      Assert.assertEquals(invokedCount, 2);
      relay.removeTransmitter(sender);
      sender.trigger([]);
      Assert.assertEquals(invokedCount, 2);
    }
  }
}