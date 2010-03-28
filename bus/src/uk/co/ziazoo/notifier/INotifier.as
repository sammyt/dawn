package uk.co.ziazoo.notifier
{
  /**
   *	The <code>INotifier</code> allows you to send and receive 
   *	notifications accross your application.
   */	
  public interface INotifier
  { 
    function trigger(notification:Object):void;
    
    function add(notificationType:Class, callback:Function, 
      polymorphic:Boolean = false):Function;
    
    function remove(callback:Function):void;
  }
}