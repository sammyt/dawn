package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  import org.flexunit.asserts.assertTrue;
  
  import some.thing.Apple;
  import some.thing.Car;
  import some.thing.CarWithTwoRadios;
  import some.thing.Engine;
  import some.thing.Ground;
  import some.thing.IRadio;
  import some.thing.LoudRadio;
  import some.thing.PlantPot;
  import some.thing.PlantPotFactory;
  import some.thing.QuietRadio;
  import some.thing.Table;
  
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.IMapper;

  public class InjectorTest
  {
    private var mapper:IMapper;
    private var injector:IInjector;
    
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
  }
}



