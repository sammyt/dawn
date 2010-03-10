package uk.co.ziazoo
{
  import uk.co.ziazoo.command.CommandMap;
  import uk.co.ziazoo.command.ICommandMap;
  import uk.co.ziazoo.injector.IConfiguration;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.notifier.INotificationBus;
  import uk.co.ziazoo.notifier.NotificationBus;

  public class Dawn implements IInjector, IConfiguration
  {
    private var injector:IInjector;
    private var bus:INotificationBus;
    private var commands:ICommandMap;
    
    public function Dawn()
    {
      injector = Injector.createInjector();
      bus = new NotificationBus();
      commands = new CommandMap( injector, bus );
      
      install( this );
    }
    
    public function inject( object:Object ):Object
    {
      return injector.inject( object );
    }
    
    public function configure( mapper:IMapper ):void
    {
      mapper.map( IInjector ).toInstance( injector );
      mapper.map( INotificationBus ).toInstance( bus );
      mapper.map( ICommandMap ).toInstance( commands );
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