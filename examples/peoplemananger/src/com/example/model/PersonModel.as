package com.example.model
{
	import com.example.handlers.IAddPersonHandler;
	import com.example.handlers.IGetPeopleHandler;
	import com.example.handlers.IPersonRequestHandler;
	import com.example.notifications.PeopleRecieved;
	import com.example.notifications.PersonRecieved;
	
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.AbstractService;
	
	import uk.co.ziazoo.notifier.INotificationBus;
	
	/**
	*	Simple model for people manager
	*/	
	public class PersonModel 
	{
		[Inject]
		/**
		*	bus used to send and receive notifications
		*/	
		public var bus:INotificationBus;
		
		/**
		*	Service used to make rpc calls to server
		*/	
		public var service:AbstractService;
		
		private var _pensil:IPencil;
		
		public function PersonModel()
		{
		}
		
		[Inject]
		/**
		*	demo of injection via factory
		*/	
		public function set pensil( value:IPencil ):void
		{
			_pensil = value;
			trace( "PersonModel", _pensil.scribble );
		}
		
		public function retrieveAllPeople( responder:IResponder ):void
		{
			var token:AsyncToken = service.getPeople.send();
			token.addResponder( responder );
		}
		
		public function retrievePerson( name:String, responder:IResponder ):void
		{
			var token:AsyncToken = service.getPerson.send( name );
			token.addResponder( responder );
		}
		
		public function addPerson( person:Person, responder:IResponder ):void
		{
			var token:AsyncToken = service.addPerson.send( person );
			token.addResponder( responder );
		}
	}
}