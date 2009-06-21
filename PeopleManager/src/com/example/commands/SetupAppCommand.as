package com.example.commands
{
	import com.example.workers.PeopleRequest;
	import com.example.workers.PersonRequest;
	
	import uk.co.ziazoo.INotificationBus;

	public class SetupAppCommand implements ICommand
	{
		private var _commands:Array;
		private var _bus:INotificationBus;
		
		public function SetupAppCommand()
		{
			_commands = new Array();
		}
		
		[Inject]
		public function set setupModelCommand( value:SetupModelCommand ):void
		{
			_commands.push( value );
		}
		
		[Inject]
		public function set setupViewCommand( value:SetupViewCommand ):void
		{
			_commands.push( value );
		}
		
		[Inject]
		public function set notificationBus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		public function execute():void
		{
			for each( var command:ICommand in _commands )
			{
				command.execute();
			}
			
			// request data
			_bus.trigger( new PeopleRequest() );
			_bus.trigger( new PersonRequest( "sam" ) );
		}
	}
}