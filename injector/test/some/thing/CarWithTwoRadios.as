package some.thing 
{
	public class CarWithTwoRadios extends CarWithOneRadio
	{
		[Inject(name="loud radio")]
		public var loudRadio:IRadio;
		
		public function CarWithTwoRadios()
		{
		}
	}
}

