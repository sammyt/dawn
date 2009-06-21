package com.example.view
{
	import com.example.handlers.IPeopleRecievedHandler;
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;
	import com.example.workers.PersonRequest;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	
	import uk.co.ziazoo.INotificationBus;

	public class PersonListPresenter 
		implements IPeopleRecievedHandler
	{
		private var _personList:PersonList;
		private var _bus:INotificationBus;
		
		public function PersonListPresenter( personList:PersonList, bus:INotificationBus )
		{
			_bus = bus;
			_personList = personList;
			_personList.addEventListener( "selectPerson", onPersonSelect );
		}
		
		private function onPersonSelect( event:Event ):void
		{
			var person:Person = _personList.dataGrid.selectedItem as Person;
			_bus.trigger( new PersonRequest( person.name ) );
		}
		
		public function onPeopleRevieved( people:IList ):void
		{
			_personList.people = people;
		}
	}
}