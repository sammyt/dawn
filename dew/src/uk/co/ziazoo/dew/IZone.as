/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 02-Oct-2010
 * Time: 13:16:34
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import flash.display.DisplayObjectContainer;

  import uk.co.ziazoo.command.ICommandMap;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.notifier.INotifier;

  public interface IZone
  {
    /**
     * A name for the Zone
     * @return zones have optional names
     */
    function get name():String;

    function set name(value:String):void;

    /**
     * The IInjector for this Zone.  If this zone has a
     * parent, that parents IInjector will be the parent
     * of this instances injector
     * @return
     */
    function get injector():IInjector

    function set injector(value:IInjector):void;

    /**
     * Each zone has a unique notifier
     * @return this zones INotifier instance
     */
    function get notifier():INotifier;

    function set notifier(value:INotifier):void;

    /**
     * Zones each have a command map to register commands within
     * @return the command map for this zone
     */
    function get commandMap():ICommandMap;

    function set commandMap(value:ICommandMap):void;

    /**
     * Used to manually create a child zone
     * @param name of the new zone
     * @return a child zone of this instance
     */
    function createChildZone(name:String):IZone;

    /**
     * The UI container for this application zone.  UI components
     * wishing to be managed by dawn need to be added to this root.
     * The same is true of child zones
     *
     * @return the root DisplayObjectContainer for this IZone
     */
    function get root():DisplayObjectContainer;

    function set root(value:DisplayObjectContainer):void;
  }
}