package com.example.commands
{
	import com.example.handlers.IPeopleRecievedHandler;
	import com.example.handlers.IPeopleRequestHandler;
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.handlers.IPersonRequestHandler;
	import com.example.model.PersonModel;
	import com.example.workers.PeopleRecieved;
	import com.example.workers.PeopleRequest;
	import com.example.workers.PersonRecieved;
	import com.example.workers.PersonRequest;
	
	import uk.co.ziazoo.notifier.INotificationBus;

	public class SetupModelCommand implements ICommand
	{
		private var _bus:INotificationBus;
		private var _personModel:PersonModel;
		
		public function SetupModelCommand()
		{
		}
		
		[Inject]
		public function set personModel( value:PersonModel ):void
		{
			_personModel = value;
		}
		
		[Inject]
		public function set notificationBus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		public function execute():void
		{
			// map workers to handlers
			/*_bus.map( PeopleRequest, IPeopleRequestHandler );
			_bus.map( PeopleRecieved, IPeopleRecievedHandler );
			_bus.map( PersonRequest, IPersonRequestHandler );
			_bus.map( PersonRecieved, IPersonRecievedHandler );
			*/
			_bus.addHandler( _personModel );
		}
	}
}