package uk.co.ziazoo.command
{
	import flexunit.framework.Assert;
	
	import uk.co.ziazoo.injector.Builder;
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.notifier.NotificationBus;

	public class CommandMapTest
	{		
		private var _map:CommandMap;
		
		public function CommandMapTest(){}
		
		[Before]
		public function setUp():void
		{
			_map = new CommandMap();
			_map.builder = new Builder();
			_map.bus = new NotificationBus();
		}
		
		[After]
		public function tearDown():void
		{
			_map = null;
		}
		
		[Test]
		public function canAddCommands():void
		{
			Assert.assertEquals( "has no commands", 0, _map.commands.length );
			_map.addCommand( MockCommand );
			Assert.assertEquals( "has one command", 1, _map.commands.length );
		}
		
		[Test]
		public function doesTriggerViaBus():void
		{
			var bus:INotificationBus = _map.bus;
			var command:MockCommand = new MockCommand();
			
			_map.builder.addConfig( new Config( command ) );
				
			_map.addCommand( MockCommand );
			
			bus.trigger( "object of same type as execute method param" );
			
			Assert.assertNotNull( "can create command", _map.builder.getObject( MockCommand ) );
			
			Assert.assertEquals( "command has executed", 1, command.invokeCount );
		}
	}
}
import uk.co.ziazoo.command.MockCommand;
import uk.co.ziazoo.injector.IConfig;
import uk.co.ziazoo.injector.mapping.IMapper;

class Config implements IConfig {
	
	private var _command:Object;
	
	public function Config( command:Object ) {
		_command = command;
	}
	
	public function create( mapper:IMapper ):void
	{
		mapper.map( MockCommand ).toInstance( _command );
	}
}