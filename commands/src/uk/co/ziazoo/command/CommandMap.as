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
		
		public function CommandMap( injector:IInjector, bus:INotificationBus )
    {
			this.injector = injector;
			this.bus = bus;
    }
    
		/**
		 * @private
		 * 
		 * the function that is invoked by the notification callback.
		 * 
		 * @param command:Command the command details of the command to invoke 
		 * @param notification:Object the trigger notification
		 */ 
		internal function invokeCommand( command:Command, notification:Object ):void
		{
			var instance:Object = injector.inject( command.commandType );
			command.invoke( instance, notification );
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function addCommand( command:Class ):void
		{
			var details:Command = new Command( command );
			
			bus.addCallback( details.triggerType, 
				function( note:Object ):void
				{
					invokeCommand( details, note );
				});
		}
	}
}