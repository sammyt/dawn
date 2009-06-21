package
{
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
			mapper.map( PersonModel, PersonModel ).singleton = true;
			
			mapper.map( PersonDetailsPresenter, PersonDetailsPresenter ).singleton = true;
			mapper.map( PersonDetails, PersonDetails ).singleton = true;
			
			mapper.map( PersonListPresenter, PersonListPresenter ).singleton = true;
			mapper.map( PersonList, PersonList ).singleton = true;
			
			mapper.map( INotificationBus, NotificationBus ).singleton = true;
			
			mapper.map( SetupAppCommand, SetupAppCommand );
			mapper.map( SetupModelCommand, SetupModelCommand );
			mapper.map( SetupViewCommand, SetupViewCommand );
			
			mapper.map( ViewContainer, ViewContainer );
		}
	}
}