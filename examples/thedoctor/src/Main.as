package
{	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import com.timelord.TheDoctor;
	
	import uk.co.ziazoo.injector.IBuilder;
	import uk.co.ziazoo.injector.Builder;
	
	public class Main extends Sprite
	{
		[Inject]
		public var doctor:TheDoctor;
		
		public function Main()
		{
			// create the builder
			var builder:IBuilder = new Builder(new Config(this));
			
			// construct this application
			builder.getObject(Main);
			
			// the doctor is now created
			// so we output the creds 
			var output:TextField = new TextField();
			output.width = stage.stageWidth;
			output.text = doctor.credits();
			
			addChild(output);
		}
	}
}