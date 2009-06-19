package com.example.app
{
	import com.example.app.notifications.ContactRecievedWorker;
	import com.example.app.notifications.IHandleContactRequest;
	
	import uk.co.ziazoo.INotificationBus;

	public class ContactModel implements IHandleContactRequest
	{
		private var _bus:INotificationBus;
		
		public function ContactModel( bus:INotificationBus )
		{
			_bus = bus;
			_bus.addHandler( this );
		}
		
		public function onContactRequest( id:int ):void
		{
			trace( "[ContactModel] onContactRequest", id );
			
			var contact:Contact = new Contact();
			contact.id = id;
			contact.name = "sammy";
			
			_bus.trigger( new ContactRecievedWorker( contact ) );
		}
	}
}