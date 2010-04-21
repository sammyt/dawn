package
{
  import com.example.model.IContactsService;
  import com.example.model.MockContactsService;

  import uk.co.ziazoo.injector.IConfiguration;
  import uk.co.ziazoo.injector.IMapper;

  public class ContactAppConfig implements IConfiguration
	{
		private var _main:Main;
		
		public function ContactAppConfig( main:Main )
		{
			_main = main;
		}
		
		public function configure(mapper:IMapper):void
		{
			mapper.map( Main ).toInstance( _main );
			mapper.map( IContactsService ).to( MockContactsService ).asSingleton();
		}
	}
}