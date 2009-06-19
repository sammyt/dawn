package com.example.app
{
	import com.example.app.notifications.IHandleContactRevieved;
	
	import uk.co.ziazoo.INotificationBus;

	public class ContactView implements IHandleContactRevieved
	{
		public function ContactView()
		{
		}
		
		public function onContact( contact:Contact ):void
		{
			trace( "[ContectView] onContact", contact );
		}
	}
}