package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  import org.flexunit.asserts.assertTrue;
  
  import some.otherthing.AnalogDial;
  import some.otherthing.DigitalDial;
  import some.otherthing.IDial;
  import some.otherthing.SlowBike;
  import some.otherthing.SlowBikeEngine;
  import some.thing.Apple;
  import some.thing.Car;
  import some.thing.CarWithTwoRadios;
  import some.thing.Ground;
  import some.thing.IRadio;
  import some.thing.LoudRadio;
  import some.thing.PlantPot;
  import some.thing.PlantPotFactory;
  import some.thing.QuietRadio;
  import some.thing.Table;
  import some.thing.Wibble;
  
  import uk.co.ziazoo.injector.IMapper;
  
  public class InjectorTest
  {
    private var mapper:IMapper;
    private var injector:Injector;
    
    public function InjectorTest()
    {
    }
    
    [Before]
    public function setUp():void
    {
      var reflector:Reflector = new Reflector();
      mapper = new Mapper( reflector );
      var dependencyFactory:DependencyFactory = new DependencyFactory();
      var injectionFactory:InjectionPointFactory = 
        new InjectionPointFactory( dependencyFactory, mapper );
      
      injector = new Injector( 
        dependencyFactory, mapper, injectionFactory, reflector );
    }
    
    [After]
    public function tearDown():void
    {
      mapper = null;
      injector = null;
    }
    
    [Test]
    public function canCreate():void
    {
      var obj:Object = injector.inject( Apple );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is an Apple", obj is Apple );
    }
    
    [Test]
    public function canCreateWithPropertyDependency():void
    {
      var obj:Object = injector.inject( Car );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is an Car", obj is Car );
      
      var car:Car = Car( obj );
      Assert.assertNotNull( "Car has an Engine", car.engine );
    }
    
    [Test]
    public function canInjectViaMethod():void
    {
      var obj:Object = injector.inject( Ground );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a Ground", obj is Ground );
      
      var ground:Ground = Ground( obj );
      
      Assert.assertNotNull( ground.apple );
      Assert.assertNotNull( ground.car );
      Assert.assertNotNull( ground.engine );
    }
    
    [Test]
    public function injectionsWithNames():void
    {
      mapper.map( Car ).to( CarWithTwoRadios );
      mapper.map( IRadio ).to( LoudRadio ).named( "loud radio" )
      mapper.map( IRadio ).to( QuietRadio );
      
      var obj:Object = injector.inject( Car );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a CarWithTwoRadios", obj is CarWithTwoRadios );
      
      var car:CarWithTwoRadios = CarWithTwoRadios( obj );
      
      Assert.assertNotNull( car.engine );
      Assert.assertNotNull( car.loudRadio );
      Assert.assertNotNull( car.radio );
      
      assertTrue( "has correct IRadio", car.loudRadio is LoudRadio );
    }
    
    [Test]
    public function injectionsByConstructor():void
    {
      var obj:Object = injector.inject( Table );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a Table", obj is Table );
      
      var table:Table = Table( obj );
      
      Assert.assertNotNull( table.plantPot );
    }
    
    [Test]
    public function factoryInjection():void
    {
      mapper.map( PlantPot ).toFactory( PlantPotFactory );
      
      var obj:Object = injector.inject( Table );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a Table", obj is Table );
      
      var table:Table = Table( obj );
      
      Assert.assertNotNull( table.plantPot );
    }
    
    [Test]
    public function instanceInjection():void
    {
      var pot:PlantPot = new PlantPot();
      mapper.map( PlantPot ).toInstance( pot );
      
      var obj:Object = injector.inject( Table );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a Table", obj is Table );
      
      var table:Table = Table( obj );
      
      Assert.assertNotNull( table.plantPot );
      Assert.assertTrue( "has correct instance", table.plantPot == pot );
    }
    
    [Test]
    public function singletonScoping():void
    {
      mapper.map( Apple ).asSingleton();
      
      var obj:Object = injector.inject( Apple );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is an Apple", obj is Apple );
      
      Assert.assertTrue( "same instance returned", obj == injector.inject( Apple ) );
    }
    
    [Test]
    public function injectNamedViaConstructor():void
    {
      var granny:Apple = new Apple()
      mapper.map( Apple );
      mapper.map( Apple ).named("granny").toInstance(granny);
      mapper.map(IRadio).to(QuietRadio);
      
      
      var obj:Object = injector.inject( Wibble );
      Assert.assertTrue( "obj is a Wibble", obj is Wibble );
      
      var wibble:Wibble = Wibble(obj);
      
      Assert.assertTrue( "has the right apple", wibble.apple == granny );
    }
    
    [Test]
    public function injectNamedInInjectSystax():void
    {
      mapper.map(IRadio).to(QuietRadio);
      mapper.map(IRadio).to(LoudRadio).named("loud");
      
      var obj:Object = injector.inject( Wibble );
      Assert.assertTrue( "obj is a Wibble", obj is Wibble );
      
      var wibble:Wibble = Wibble(obj);
      
      Assert.assertTrue( "has the right radio", wibble.radio is LoudRadio );
    }
    
    [Test]
    public function createBikeWithContreteConstructorArg():void
    {
      injector.map(IDial).to(DigitalDial);
      injector.map(IDial).named("analog").to(AnalogDial);
      injector.map(String).named("bike name").toInstance("my bike");
      
      var bike:SlowBike = SlowBike(injector.inject( SlowBike ));
      
      Assert.assertTrue( "engine is slow engine", bike.engine is SlowBikeEngine );
      Assert.assertNotNull( bike.dial );
      Assert.assertTrue( "dial is analog", bike.dial is AnalogDial );
      Assert.assertTrue( "gets the name", bike.name == "my bike" );
    }
    
    [Test]
    public function doesPostConstructGetCalled():void
    {
      var engine:SlowBikeEngine = SlowBikeEngine(injector.inject(SlowBikeEngine));
      Assert.assertTrue( "PostConstruct method called", engine.invokeCount == 1 );
    }
    
    [Test]
    public function doesDependenciesInjectedGetCalled():void
    {
      var dial:DigitalDial = DigitalDial(injector.inject(DigitalDial));
      Assert.assertTrue( "DependenciesInjected method called", dial.invokeCount == 1 );
    }
  }
}



