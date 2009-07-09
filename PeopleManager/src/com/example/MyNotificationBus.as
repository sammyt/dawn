package com.example
{
	import uk.co.ziazoo.notifier.NotificationBus;

	public class MyNotificationBus extends NotificationBus
	{
		public function MyNotificationBus()
		{
			super();
		}
		
		override public function trigger( worker:Object ):void
		{
			trace( "MyBus.trigger", worker );
			super.trigger( worker );
		}
	}
}