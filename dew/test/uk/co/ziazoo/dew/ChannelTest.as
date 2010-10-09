/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 09/10/2010
 * Time: 14:56
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import org.flexunit.Assert;

  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class ChannelTest
  {
    public function ChannelTest()
    {
    }

    [Test]
    public function canFilter():void
    {
      var source:INotifier = new Notifier();
      var target:INotifier = new Notifier();

      var channel:IChannel = new Channel(source, target);

      var invokeCount:int = 0;

      channel.filter(Array, function(msg:Array):Boolean
      {
        return invokeCount == 0;
      });

      target.listen(Object, function(message:Object):void
      {
        invokeCount ++;
      }, true);

      source.trigger([]);

      Assert.assertEquals(1, invokeCount);

      source.trigger([]);

      Assert.assertEquals(1, invokeCount);
    }
  }
}
