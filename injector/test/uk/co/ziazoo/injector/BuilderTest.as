package uk.co.ziazoo.injector {
	import flexunit.framework.TestCase;
	
	import uk.co.ziazoo.injector.Builder;
	import uk.co.ziazoo.injector.IConfig;
	import uk.co.ziazoo.injector.IMapper;
	
	import some.thing.Apple;
	import some.thing.Car;
	import some.thing.Engine;
	import some.thing.IRadio;
	import some.thing.LoudRadio;
	import some.thing.QuietRadio;
	import some.thing.CarWithOneRadio;
	import some.thing.CarWithTwoRadios;
	
	public class BuilderTest extends TestCase implements IConfig
	{
		private var _builder:Builder;
		
		public function BuilderTest(methodName:String=null)
		{
			super(methodName);
		}
		
		override public function setUp():void
		{
			_builder = new Builder( this );
		}
		
		override public function tearDown():void
		{
			_builder = null;
		}
		
		public function create( mapper:IMapper ):void
		{
			mapper.map(Apple).toSelf().asSingleton();
			mapper.map(IRadio).toClass(QuietRadio);
			mapper.map(IRadio).toClass(LoudRadio).withName("loud radio");
		}
		
		public function testCreateCar():void
		{
			var car:Car = _builder.getObject(Car) as Car;
			assertNotNull("created car", car);
			assertNotNull("created car with engine", car.engine);
		}
		
		public function testCarAndEngineAreTransient():void
		{
			var car1:Car = _builder.getObject(Car) as Car;
			var car2:Car = _builder.getObject(Car) as Car;
			
			assertTrue( "the cars are not the same", car1 != car2 );
			assertTrue( "the engines are not the same", car1.engine != car2.engine );
		}
		
		public function testAppleIsASingleton():void
		{
			var apple1:Apple = _builder.getObject(Apple) as Apple;
			var apple2:Apple = _builder.getObject(Apple) as Apple;
			
			assertTrue( "the apples are the same object", apple1 == apple2 );
		}
		
		public function testCreateCarWithRadio():void
		{
			var car:CarWithOneRadio = _builder.getObject(CarWithOneRadio) as CarWithOneRadio;
			
			assertNotNull("we have car", car);
			assertNotNull("car has radio", car.radio);
			assertNotNull("car has engine", car.engine);
		}
		
		public function testCreateCarWithTwoRadios():void
		{
			var car:CarWithTwoRadios = _builder.getObject(CarWithTwoRadios) as CarWithTwoRadios;
			
			assertNotNull("we have car", car);
			assertNotNull("car has radio", car.radio);
			assertNotNull("car has loud radio", car.loudRadio);
			assertNotNull("car has engine", car.engine);
		}
	}
}

