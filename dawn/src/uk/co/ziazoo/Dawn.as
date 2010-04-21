package uk.co.ziazoo
{
  import uk.co.ziazoo.command.CommandMap;
  import uk.co.ziazoo.command.ICommandMap;
  import uk.co.ziazoo.injector.IConfiguration;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class Dawn
  {
    private var injector:IInjector;
    private var bus:INotifier;
    private var commands:ICommandMap;
    
    public function Dawn()
    {
      injector = Injector.createInjector();
      bus = new Notifier();
      commands = new CommandMap( injector, bus );
      
      map( IInjector ).toInstance( injector );
      map( INotifier ).toInstance( bus );
      map( ICommandMap ).toInstance( commands );
    }
    
    public function inject( object:Object ):Object
    {
      return injector.inject( object );
    }
    
    public function install( configuration:IConfiguration ):void
    {
      injector.install( configuration );
    }
    
    public function map( clazz:Class ):IMappingBuilder
    {
      return injector.map( clazz );
    }
  }
}