package some.thing
{	
	public class Ground
	{
		public var engine:Engine;
		public var apple:Apple;
		public var car:Car;
		
		public function Ground()
		{
		}
		
		[Inject]
		public function setThings( engine:Engine, apple:Apple, car:Car ):void
		{
			this.engine = engine;
			this.apple = apple;
			this.car = car;
		}
	}
}