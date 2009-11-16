package
{
	import com.example.model.MockContactsService;
	import com.example.model.IContactsService;
	
	import uk.co.ziazoo.injector.IConfig;
	import uk.co.ziazoo.injector.IMapper;
	
	public class ContactAppConfig implements IConfig
	{
		private var _main:Main;
		
		public function ContactAppConfig( main:Main )
		{
			_main = main;
		}
		
		public function create(mapper:IMapper):void
		{
			mapper.map( Main ).toInstance( _main );
			mapper.map( IContactsService ).toClass( MockContactsService ).asSingleton();
		}
	}
}