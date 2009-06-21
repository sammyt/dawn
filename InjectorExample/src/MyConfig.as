package
{
	import com.example.ISpeaker;
	import com.example.Megaphone;
	import com.example.Speaker;
	
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IMappingConfiguration;

	public class MyConfig implements IMappingConfiguration
	{
		public function MyConfig()
		{
			
		}
		
		public function create( mapper:IMapper ):void
		{
			mapper.map( ISpeaker, Speaker );
			mapper.map( Megaphone, Megaphone );
		}
	}
}