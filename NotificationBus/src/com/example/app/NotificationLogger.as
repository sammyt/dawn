package com.example.app
{
	import com.example.app.notifications.IHandleContactRequest;
	import com.example.app.notifications.IHandleContactRevieved;
	
	import uk.co.ziazoo.INotificationBus;

	public class NotificationLogger implements IHandleContactRequest, IHandleContactRevieved
	{
		public function NotificationLogger()
		{
		}
		
		public function onContactRequest(id:int):void
		{
			trace( "[NotificationLogger] onContactRequest", id );
		}
		
		public function onContact(contact:Contact):void
		{
			trace( "[NotificationLogger] onContact", contact );
		}
	}
}