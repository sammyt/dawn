package com.example.view
{
	import com.example.handlers.IPeopleRecievedHandler;
	import com.example.model.Person;
	import com.example.notifications.PersonRequest;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	
	import uk.co.ziazoo.notifier.INotificationBus;

	public class PersonListPresenter 
	{
		private var _personList:PersonList;
		
		[Inject]
		public var bus:INotificationBus;
		
		public function PersonListPresenter()
		{
		}
		
		[Inject]
		public function set personList( value:PersonList ):void
		{
			_personList = value;
			_personList.addEventListener( "selectPerson", onPersonSelect );	
		}
		
		private function onPersonSelect( event:Event ):void
		{
			var person:Person = _personList.dataGrid.selectedItem as Person;
			bus.trigger( new PersonRequest( person.name ) );
		}
		
		public function onPeopleRevieved( people:IList ):void
		{
			_personList.people = people;
		}
	}
}