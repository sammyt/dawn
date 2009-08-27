package uk.co.ziazoo.rpc
{
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.notifier.INotificationBus;

	public class CommandDispatcher
	{
		private var _bus:INotificationBus;
		private var _builder:IBuilder;
		private var _commands:Array;
		
		public function CommandDispatcher()
		{
		}
		
		[DependenciesInjected]
		public function init():void
		{
			bus.addCallback( IRpcNotification, invokeCommand );
		}
		
		protected function invokeCommand( notification:IRpcNotification ):void
		{
			for each( var details:CommandDetails in commands )
			{
				if( notification is details.triggerType )
				{
					var command:Object = builder.getObject( details.commandType );
					details.invoke( command, notification );
				}
			}
		}
		
		public function addCommand( command:Class ):void
		{
			commands.push( new CommandDetails( command ) );
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
		
		protected function get commands():Array
		{
			if( !_commands )
			{
				_commands = new Array();
			}
			return _commands;
		}
	}
}