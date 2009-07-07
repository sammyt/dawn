package com.example.view
{
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;
	
	import uk.co.ziazoo.INotificationBus;

	public class PersonDetailsPresenter implements IPersonRecievedHandler
	{
		[Inject]
		public var details:PersonDetails;
		
		public function PersonDetailsPresenter()
		{
			
		}
		
		[Inject(name="someCopy")]
		public function set someCopy( value:String ):void
		{
			trace( value );
		}
		
		public function onPersonRevieved( person:Person ):void
		{
			details.person = person;
		}
	}
}