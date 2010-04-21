package uk.co.ziazoo.command
{
  import org.flexunit.Assert;

  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class CommandMapTest
  {		
    private var commands:CommandMap;
    private var injector:IInjector;
    private var bus:INotifier;
    
    public function CommandMapTest(){}
    
    [Before]
    public function setUp():void
    {
      injector = Injector.createInjector();
      bus = new Notifier();
      
      commands = new CommandMap( injector, bus );
    }
    
    [After]
    public function tearDown():void
    {
      commands = null;
    }
    
    [Test]
    public function doesTriggerViaBus():void
    {
      var command:MockCommand = new MockCommand();
      
      injector.map( MockCommand ).toInstance( command );
      
      commands.add( MockCommand );
      
      bus.trigger( "object of same type as execute method param" );
      
      Assert.assertNotNull( "can create command", injector.inject( MockCommand ) );
      Assert.assertTrue( "same instance", injector.inject( MockCommand ) == command );
      Assert.assertEquals( "command has executed", 1, command.invokeCount );
    }
  }
}