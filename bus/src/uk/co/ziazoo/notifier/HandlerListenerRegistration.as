package uk.co.ziazoo.notifier 
{
  internal class HandlerListenerRegistration implements IListenerRegistration
  {	
    private var _bus:INotificationBus;
    private var _handler:Object;
    
    public function HandlerListenerRegistration( bus:INotificationBus, handler:Object )
    {
      _bus = bus;
      _handler = handler;
    }
    
    public function remove():void
    {
      _bus.removeHandler( _handler );
    }
  }
}

