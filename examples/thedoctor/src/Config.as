package  
{
	import com.timelord.RoseTyler;
	import com.timelord.Daleks;
	import com.timelord.IMission;
	import com.timelord.IAssistant;
	
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IConfig;
	
	public class Config implements IConfig
	{
		private var _main:Main;
		
		public function Config(main:Main):void
		{
			_main = main;
		}
		
		public function create(mapper:IMapper):void
		{
			mapper.map(Main).toInstance(_main);
			mapper.map(IAssistant).toClass(RoseTyler);
			mapper.map(IMission).toClass(Daleks);
		}
	}
}