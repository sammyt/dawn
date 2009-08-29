package com.example.view
{
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;

	public class PersonDetailsPresenter implements IPersonRecievedHandler
	{
		[Inject]
		public var details:PersonDetails;
		
		public function PersonDetailsPresenter()
		{
			
		}
		
		[DependenciesInjected]
		public function init():void
		{
			trace( this, "init" );
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