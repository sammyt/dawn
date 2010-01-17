package uk.co.ziazoo.command
{
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.notifier.INotificationBus;

	/**
	 * Implements ICommandMap allowing users to register commands with
	 * Dawn.
	 */ 
	public class CommandMap implements ICommandMap
	{
		private var _bus:INotificationBus;
		private var _builder:IBuilder;
		private var _commands:Array;
		
		public function CommandMap(){}
		
		/**
		 * @private
		 * 
		 * the function that is invoked by the notification callback.  Invokes
		 * all commands with triggerType of notification
		 * 
		 * @param notification:Object the trigger notification
		 */ 
		internal function invokeCommand( notification:Object ):void
		{
			for each( var command:Command in commands )
			{
				if( notification is command.triggerType )
				{
					var instance:Object = builder.getObject( command.commandType );
					command.invoke( instance, notification );
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function addCommand( command:Class ):void
		{
			var details:Command = new Command( command );
			commands.push( details );
			
			bus.addCallback( details.triggerType, invokeCommand );
		}
		
		[Inject]
		
		/**
		 * The <code>IBuilder</code> object that will be used to 
		 * construct the command objects
		 */ 
		public function get builder():IBuilder
		{
			return _builder;
		}
		
		public function set builder( value:IBuilder ):void
		{
			_builder = value;
		}
		
		[Inject]
		
		/**
		 * instance of <code>INotificationBus</code> where notification will
		 * to listened for to trigger the commands
		 */ 
		public function get bus():INotificationBus
		{
			return _bus;
		}
		
		public function set bus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		/**
		 * @private
		 * 
		 * list of mapped <code>Command</code> objects
		 */ 
		internal function get commands():Array
		{
			if( !_commands )
			{
				_commands = new Array();
			}
			return _commands;
		}
	}
}