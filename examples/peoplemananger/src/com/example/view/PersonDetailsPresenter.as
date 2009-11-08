package com.example.view
{
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;

	public class PersonDetailsPresenter
	{
		[Inject]
		public var details:PersonDetails;
		
		[Inject]
		public var bus:INotificationManager;
		
		public function PersonDetailsPresenter()
		{
			
		}
		
		[DependenciesInjected]
		public function init():void
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