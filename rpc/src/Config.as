package
{
	import mx.core.Application;
	
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.injector.IConfig;
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.notifier.NotificationBus;
	import uk.co.ziazoo.rpc.CommandDispatcher;
	
	public class Config implements IConfig
	{
		private var _builder:IBuilder;
		
		public function Config( builder:IBuilder )
		{
			_builder = builder;
		}
		
		public function create( mapper:IMapper ):void
		{
			mapper.map( IBuilder ).toInstance( _builder );
			mapper.map( MoreThoughts ).toInstance( Application.application );
			mapper.map( CommandDispatcher ).toSelf().asSingleton();
			mapper.map( INotificationBus ).toClass( NotificationBus ).asSingleton();
			mapper.map( GetPersonListRpcCommand ).toSelf();
		}
	}
}