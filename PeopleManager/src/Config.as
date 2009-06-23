package
{
	import com.example.MyNotificationBus;
	import com.example.commands.SetupAppCommand;
	import com.example.commands.SetupModelCommand;
	import com.example.commands.SetupViewCommand;
	import com.example.model.PersonModel;
	import com.example.view.PersonDetails;
	import com.example.view.PersonDetailsPresenter;
	import com.example.view.PersonList;
	import com.example.view.PersonListPresenter;
	import com.example.view.ViewContainer;
	
	import uk.co.ziazoo.INotificationBus;
	import uk.co.ziazoo.NotificationBus;
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IMappingConfiguration;

	public class Config implements IMappingConfiguration
	{
		public function Config()
		{
		}
		
		public function create(mapper:IMapper):void
		{
			mapper.map( PersonModel ).singleton = true;
			
			mapper.map( PersonDetailsPresenter ).singleton = true;
			mapper.map( PersonDetails ).singleton = true;
			
			mapper.map( PersonListPresenter ).singleton = true;
			mapper.map( PersonList ).singleton = true;
			
			mapper.map( INotificationBus, NotificationBus ).singleton = true;
			mapper.map( INotificationBus, MyNotificationBus, "MyBus" ).singleton = true;
			
			mapper.map( SetupAppCommand );
			mapper.map( SetupModelCommand );
			mapper.map( SetupViewCommand );
			
			mapper.map( ViewContainer );
		}
	}
}