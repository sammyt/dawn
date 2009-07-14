package
{
	import com.example.MyNotificationBus;
	import com.example.model.IPencil;
	import com.example.model.PencilGenerator;
	import com.example.model.PersonModel;
	import com.example.view.AddPersonForm;
	import com.example.view.AddPersonFormPresenter;
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
			
			mapper.map( PersonListPresenter ).toSelf().asSingleton();
			mapper.map( PersonList ).toInstance( app.view.list );
			
			mapper.map( AddPersonFormPresenter ).toSelf().asSingleton();
			mapper.map( AddPersonForm ).toInstance( app.view.addForm );
			
			mapper.map( String ).toInstance( "OMG, String injection" ).withName( "someMessage" );
			mapper.map( String ).toInstance( "WOW, a trace statement" ).withName( "someCopy" );
			
			mapper.map( INotificationBus ).toClass( NotificationBus ).asSingleton();
			mapper.map( INotificationBus ).toClass( MyNotificationBus ).withName( "MyBus" ).asSingleton();
			
			mapper.map( ViewContainer ).toInstance( app.view );
			mapper.map( PeopleManager ).toInstance( app );
		}
	}
}