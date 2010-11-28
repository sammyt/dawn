package uk.co.ziazoo.command
{
  import org.flexunit.Assert;

  import uk.co.ziazoo.fussy.Fussy;
  import uk.co.ziazoo.fussy.query.IQueryBuilder;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class CommandMapTest
  {
    private var commands:CommandMap;
    private var injector:IInjector;
    private var bus:INotifier;

    public function CommandMapTest()
    {
    }

    [Before]
    public function setUp():void
    {
      injector = Injector.createInjector();
      bus = new Notifier();
      commands = new CommandMap(injector, bus, new Fussy().query());
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

      injector.map(MockCommand).toInstance(command);

      commands.add(MockCommand);

      bus.trigger("object of same type as execute method param");

      Assert.assertNotNull("can create command", injector.inject(MockCommand));
      Assert.assertTrue("same instance", injector.inject(MockCommand) == command);
      Assert.assertEquals("command has executed", 1, command.invokeCount);
    }

    [Test(expects="Error")]
    public function cannotAddCommandWithNoExecuteMethod():void
    {
      var command:MockCommandNoExecute = new MockCommandNoExecute();
      injector.map(MockCommandNoExecute).toInstance(command);
      commands.add(MockCommandNoExecute);
    }

    [Test(expects="Error")]
    public function cannotAddCommandWithManyExecuteMethods():void
    {
      var command:MockCommandManyExecutes = new MockCommandManyExecutes();
      injector.map(MockCommandManyExecutes).toInstance(command);
      commands.add(MockCommandManyExecutes);
    }

    [Test(expects="Error")]
    public function cannotAddCommandWithNoParams():void
    {
      var command:MockCommandNoParam = new MockCommandNoParam();
      injector.map(MockCommandNoParam).toInstance(command);
      commands.add(MockCommandNoParam);
    }


    [Test(expects="Error")]
    public function cannotAddCommandWithTooManyParams():void
    {
      var command:MockCommandTooManyParams = new MockCommandTooManyParams();
      injector.map(MockCommandTooManyParams).toInstance(command);
      commands.add(MockCommandTooManyParams);
    }

    [Test]
    public function createByInjector():void
    {
      var injector:IInjector = Injector.createInjector();

      injector.map(IInjector).toInstance(injector);
      injector.map(IQueryBuilder).toInstance(new Fussy().query());
      injector.map(INotifier).to(Notifier).asSingleton();
      injector.map(ICommandMap).to(CommandMap);

      var commandMap:ICommandMap = injector.inject(ICommandMap) as ICommandMap;

      Assert.assertNotNull(commandMap);

      var command:MockCommand = new MockCommand();

      injector.map(MockCommand).toInstance(command);

      commandMap.add(MockCommand);

      var notifier:INotifier = INotifier(injector.inject(INotifier));
      notifier.trigger("object of same type as execute method param");

      Assert.assertNotNull("can create command", injector.inject(MockCommand));
      Assert.assertTrue("same instance", injector.inject(MockCommand) == command);
      Assert.assertEquals("command has executed", 1, command.invokeCount);
    }
  }
}