/**
 *
 */
package uk.co.ziazoo.dew
{
  import flash.display.DisplayObjectContainer;

  import uk.co.ziazoo.command.CommandMap;
  import uk.co.ziazoo.command.ICommandMap;
  import uk.co.ziazoo.fussy.Fussy;
  import uk.co.ziazoo.fussy.query.IQuery;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class Zone implements IZone
  {
    private var _name:String;
    private var _parent:IZone;
    private var _injector:IInjector;
    private var _notifier:INotifier;
    private var _root:DisplayObjectContainer;
    private var _commandMap:ICommandMap;

    public function Zone(name:String = "", parent:IZone = null)
    {
      _name = name;
      _parent = parent;
    }

    /**
     * @inheritDoc
     */
    public function get name():String
    {
      return _name;
    }

    public function set name(value:String):void
    {
      _name = value;
    }

    /**
     * @inheritDoc
     */
    public function createChildZone(name:String):IZone
    {
      var child:IZone = new Zone(name, this);
      child.injector = injector.createChildInjector();
      return child;
    }

    /**
     * @inheritDoc
     */
    public function get injector():IInjector
    {
      if (!_injector) {
        _injector = Injector.createInjector();

      }
      return _injector;
    }

    public function set injector(value:IInjector):void
    {
      _injector = value;
    }

    /**
     * @inheritDoc
     */
    public function get notifier():INotifier
    {
      if (!_notifier) {
        _notifier = new Notifier();
      }
      return _notifier;
    }

    public function set notifier(value:INotifier):void
    {
      _notifier = value;
    }

    /**
     * @inheritDoc
     */
    public function get root():DisplayObjectContainer
    {
      return _root;
    }

    public function set root(value:DisplayObjectContainer):void
    {
      _root = value;
    }

    /**
     * @inheritDoc
     */
    public function get commandMap():ICommandMap
    {
      if (!_commandMap) 
      {
        commandMap = new CommandMap(injector, notifier, new Fussy().query());
      }
      return _commandMap;
    }

    public function set commandMap(value:ICommandMap):void
    {
      _commandMap = value;
    }
  }
}