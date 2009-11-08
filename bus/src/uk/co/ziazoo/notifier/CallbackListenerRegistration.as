package uk.co.ziazoo.notifier 
{	
	internal class CallbackListenerRegistration implements IListenerRegistration
	{	
		private var _bus:INotificationBus;
		private var _callback:Callback;
		
		public function CallbackListenerRegistration( bus:INotificationBus, callback:Callback )
		{
			_callback = callback;
			_bus = bus;
		}
		
		public function remove():void
		{
			_bus.removeCallback( _callback.type, _callback.callback );
		}
	}
}

