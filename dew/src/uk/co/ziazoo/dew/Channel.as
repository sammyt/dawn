/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08-Oct-2010
 * Time: 20:16:26
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import uk.co.ziazoo.notifier.INotifier;

  public class Channel implements IChannel
  {
    private var source:INotifier;
    private var target:INotifier;
    private var _mandateFilter:Boolean = false;
    private var _filters:Filters;

    public function Channel(source:INotifier, target:INotifier)
    {
      this.source = source;
      this.target = target;

      this.source.listen(Object, onMessage, true);
    }

    private function onMessage(message:Object):void
    {
      if (mandateFilter) {
        if (filters.doesMessagePassFilters(message)) {
          target.trigger(message);
        }
      }
      else {
        if (filters.isTypeFiltered(message)) {
          if (filters.doesMessagePassFilters(message)) {
            target.trigger(message);
          }
        }
        else {
          target.trigger(message);
        }
      }
    }

    public function get mandateFilter():Boolean
    {
      return _mandateFilter;
    }

    public function set mandateFilter(value:Boolean):void
    {
      _mandateFilter = value;
    }

    public function filter(type:Class, condition:Function, polymorphic:Boolean = false):void
    {
      filters.add(type, condition, polymorphic)
    }

    private function get filters():Filters
    {
      if (!_filters) {
        _filters = new Filters();
      }
      return _filters;
    }

    public function close():void
    {
      source.remove(Object, onMessage);
    }
  }
}