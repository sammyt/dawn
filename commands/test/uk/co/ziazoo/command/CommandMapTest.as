package uk.co.ziazoo.command
{
	import org.flexunit.Assert;
	
	import uk.co.ziazoo.injector.IInjector;
	import uk.co.ziazoo.injector.impl.Injector;
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.notifier.NotificationBus;
  
	public class CommandMapTest
	{		
		private var commands:CommandMap;
    private var injector:IInjector;
    private var bus:INotificationBus;
		
		public function CommandMapTest(){}
		
		[Before]
		public function setUp():void
		{
      injector = Injector.createInjector();
      bus = new NotificationBus();
      
			commands = new CommandMap( injector, bus );
		}
		
		[After]
		public function tearDown():void
		{
			commands = null;
		}
		
		[Test]
		public function canAddCommands():void
		{
			Assert.assertEquals( "has no commands", 0, commands.commands.length );
			commands.addCommand( MockCommand );
			Assert.assertEquals( "has one command", 1, commands.commands.length );
		}
		
		[Test]
		public function doesTriggerViaBus():void
		{
			var command:MockCommand = new MockCommand();
			
			injector.install( new Configuration( command )	);
			commands.addCommand( MockCommand );
			
			bus.trigger( "object of same type as execute method param" );
			
			Assert.assertNotNull( "can create command", injector.inject( MockCommand ) );
			
			Assert.assertEquals( "command has executed", 1, command.invokeCount );
		}
	}
}
import uk.co.ziazoo.command.MockCommand;
import uk.co.ziazoo.injector.IConfiguration;
import uk.co.ziazoo.injector.IMapper;

class Configuration implements IConfiguration
{
  private var instance:MockCommand;
  
  public function Configuration( instance:MockCommand )
  {
    this.instance = instance;
  }
  public function configure( mapper:IMapper ):void
  {
    mapper.map( MockCommand ).toInstance( instance );
  }
}