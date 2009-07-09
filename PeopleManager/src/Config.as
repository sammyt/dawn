package
{
	import com.example.MyNotificationBus;
	import com.example.commands.SetupAppCommand;
	import com.example.commands.SetupModelCommand;
	import com.example.commands.SetupViewCommand;
	import com.example.model.IPencil;
	import com.example.model.PencilGenerator;
	import com.example.model.PersonModel;
	import com.example.view.PersonDetails;
	import com.example.view.PersonDetailsPresenter;
	import com.example.view.PersonList;
	import com.example.view.PersonListPresenter;
	import com.example.view.ViewContainer;
	
	import mx.core.Application;
	
	import uk.co.ziazoo.injector.IConfig;
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.notifier.NotificationBus;

	public class Config implements IConfig
	{
		public function Config()
		{
		}
		
		public function create( mapper:IMapper ):void
		{
			var app:PeopleManager = Application.application as PeopleManager;
			
			mapper.map( PersonModel ).toSelf().asSingleton();
			
			mapper.map( IPencil ).toFactory( PencilGenerator );
			
			mapper.map( PersonDetailsPresenter ).toSelf().asSingleton();
			mapper.map( PersonDetails ).toInstance( app.view.details );
			
			mapper.map( String ).toInstance( "OMG, String injection" ).withName( "someMessage" );
			mapper.map( String ).toInstance( "WOW, a trace statement" ).withName( "someCopy" );
			
			mapper.map( PersonListPresenter ).toSelf().asSingleton();
			mapper.map( PersonList ).toInstance( app.view.list );
			
			mapper.map( INotificationBus ).toClass( NotificationBus ).asSingleton();
			mapper.map( INotificationBus ).toClass( MyNotificationBus ).withName( "MyBus" ).asSingleton();
			
			mapper.map( SetupAppCommand ).toSelf();
			mapper.map( SetupModelCommand ).toSelf();
			mapper.map( SetupViewCommand ).toSelf();
			
			mapper.map( ViewContainer ).toInstance( app.view );
		}
	}
}