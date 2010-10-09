/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08-Oct-2010
 * Time: 20:04:44
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  public interface IChannel
  {
    function get mandateFilter():Boolean;

    function set mandateFilter(value:Boolean):void;

    function filter(type:Class, condition:Function, polymorphic:Boolean = false):void;

    function close():void;
  }
}