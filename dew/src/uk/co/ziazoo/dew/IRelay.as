/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08-Oct-2010
 * Time: 19:23:40
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import uk.co.ziazoo.notifier.INotifier;

  public interface IRelay
  {
    function addTransmitter(notifier:INotifier):IChannel;

    function removeTransmitter(notifier:INotifier):void;

    function addReceiver(notifier:INotifier):IChannel;

    function removeReceiver(notifier:INotifier):void;
  }
}