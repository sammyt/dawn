package uk.co.ziazoo.command
{
	import uk.co.ziazoo.injector.IInjector;
	import uk.co.ziazoo.notifier.INotificationBus;

	/**
	 * Implements ICommandMap allowing users to register commands with
	 * Dawn.
	 */ 
	public class CommandMap implements ICommandMap
	{
		private var bus:INotificationBus;
		private var injector:IInjector;
		private var _commands:Array;
		
		public function CommandMap( injector:IInjector, bus:INotificationBus )
    {
      this.injector = injector;
      this.bus = bus;
    }
    
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
					var instance:Object = injector.inject( command.commandType );
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