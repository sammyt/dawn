package
{
	import uk.co.ziazoo.command.CommandMap;
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.injector.IConfig;
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.notifier.NotificationBus;
	
	public class BasicDawnConfig implements IConfig
	{
		private var _builder:IBuilder;
		
		public function BasicDawnConfig( builder:IBuilder )
		{
			_builder = builder;
		}
		
		public function create(mapper:IMapper):void
		{
			mapper.map( IBuilder ).toInstance( _builder );
			mapper.map( INotificationBus ).toClass( NotificationBus ).asSingleton();
		}
	}
}