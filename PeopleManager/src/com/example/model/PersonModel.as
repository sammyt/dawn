package com.example.model
{
	import com.example.handlers.IAddPersonHandler;
	import com.example.handlers.IPeopleRequestHandler;
	import com.example.handlers.IPersonRequestHandler;
	import com.example.notifications.PeopleRecieved;
	import com.example.notifications.PersonRecieved;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	import uk.co.ziazoo.notifier.INotificationBus;

	public class PersonModel 
		implements IPeopleRequestHandler, IPersonRequestHandler, IAddPersonHandler
	{
		[Inject]
		public var bus:INotificationBus;
		
		private var _people:IList;
		private var _pensil:IPencil;
		
		public function PersonModel()
		{
			var p1:Person = new Person( "sam", 26 );
			var p2:Person = new Person( "becky", 26 );
			var p3:Person = new Person( "wibble", 200 );
			_people = new ArrayCollection( [ p1, p2, p3 ] );
		}
		
		[Inject]
		public function set pensil( value:IPencil ):void
		{
			_pensil = value;
			trace( "PersonModel", _pensil.scribble );
		}
		
		public function retrieveAllPeople( responder:IResponder = null ):void
		{
			bus.trigger( new PeopleRecieved( _people ) );
		}
		
		public function retrievePerson( name:String ):void
		{
			for each( var person:Person in _people )
			{
				if( person.name == name )
				{
					bus.trigger( new PersonRecieved( person ) );
					return;
				}
			}
		}
		
		public function addPerson( person:Person ):void
		{
			_people.addItem( person );
			retrieveAllPeople();
		}
	}
}