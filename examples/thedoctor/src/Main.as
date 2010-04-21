package
{
  import com.timelord.Daleks;
  import com.timelord.IAssistant;
  import com.timelord.IMission;
  import com.timelord.RoseTyler;
  import com.timelord.TheDoctor;

  import flash.display.Sprite;
  import flash.text.TextField;

  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.impl.Injector;

  public class Main extends Sprite
	{
		public function Main()
		{
			var injector:IInjector = Injector.createInjector();
			injector.map(IAssistant).to(RoseTyler);
			injector.map(IMission).to(Daleks);
			
			var doctor:TheDoctor = TheDoctor(injector.inject(TheDoctor));	
			
			var output:TextField = new TextField();
			output.width = stage.stageWidth;
			output.text = doctor.credits();
			
			addChild(output);
		}
	}
}