/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08-Oct-2010
 * Time: 19:40:03
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import flash.utils.Dictionary;

  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class Relay implements IRelay
  {
    private var _transmitters:Dictionary;
    private var _receivers:Dictionary;
    private var _notifier:INotifier;

    public function Relay()
    {
      _notifier = new Notifier();
    }

    public function addTransmitter(source:INotifier):IChannel
    {
      var channel:IChannel = new Channel(source, _notifier);
      transmitters[source] = channel;
      return channel;
    }

    public function addReceiver(target:INotifier):IChannel
    {
      var channel:IChannel = new Channel(_notifier, target);
      receivers[target] = channel;
      return channel;
    }

    public function removeTransmitter(notifier:INotifier):void
    {
      var channel:IChannel = transmitters[notifier] as IChannel;
      if (channel) {
        channel.close();
        delete transmitters[notifier];
      }

    }

    public function removeReceiver(notifier:INotifier):void
    {
      var channel:IChannel = receivers[notifier] as IChannel;
      if (channel) {
        channel.close();
        delete receivers[notifier];
      }
    }

    private function get transmitters():Dictionary
    {
      if (!_transmitters) {
        _transmitters = new Dictionary();
      }
      return _transmitters;
    }

    private function get receivers():Dictionary
    {
      if (!_receivers) {
        _receivers = new Dictionary();
      }
      return _receivers;
    }
  }
}