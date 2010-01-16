package uk.co.ziazoo.command
{
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.notifier.INotificationBus;

	public class CommandMap implements ICommandMap
	{
		private var _bus:INotificationBus;
		private var _builder:IBuilder;
		private var _commands:Array;
		
		public function CommandMap()
		{
		}
		
		internal function invokeCommand( notification:Object ):void
		{
			for each( var details:Command in commands )
			{
				if( notification is details.triggerType )
				{
					var command:Object = builder.getObject( details.commandType );
					details.invoke( command, notification );
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
		public function get builder():IBuilder
		{
			return _builder;
		}
		
		public function set builder( value:IBuilder ):void
		{
			_builder = value;
		}
		
		[Inject]
		public function get bus():INotificationBus
		{
			return _bus;
		}
		
		public function set bus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
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