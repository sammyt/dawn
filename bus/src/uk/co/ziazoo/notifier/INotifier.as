package uk.co.ziazoo.notifier
{
  /**
   *	The <code>INotifier</code> allows you to send and receive 
   *	notifications accross your application.
   */	
  public interface INotifier
  { 
    function trigger(payload:Object):void;
    
    function listen(type:Class, callback:Function, 
      polymorphic:Boolean = false):Function;
    
    function remove(type:Class, callback:Function):void;
  }
}