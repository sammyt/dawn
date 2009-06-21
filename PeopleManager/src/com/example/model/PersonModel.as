package com.example.model
{
	import com.example.handlers.IPeopleRequestHandler;
	import com.example.handlers.IPersonRequestHandler;
	import com.example.workers.PeopleRecieved;
	import com.example.workers.PersonRecieved;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	
	import uk.co.ziazoo.INotificationBus;

	public class PersonModel 
		implements IPeopleRequestHandler, IPersonRequestHandler
	{
		public var bus:INotificationBus;
		
		private var _people:IList;
		
		public function PersonModel( bus:INotificationBus )
		{
			this.bus = bus;
			this.bus.addHandler( this );
			
			var p1:Person = new Person( "sam", 26 );
			var p2:Person = new Person( "becky", 26 );
			var p3:Person = new Person( "wibble", 200 );
			
			_people = new ArrayCollection( [ p1, p2, p3 ] );
		}
		
		public function retrieveAllPeople():void
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
			// what do I do on fail?
		}
	}
}