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
      mapper = new Mapper();
      var reflector:Reflector = new Reflector();
      var dependencyFactory:DependencyFactory = new DependencyFactory();
      var injectionFactory:InjectionPointFactory = new InjectionPointFactory( dependencyFactory, mapper );
      
      injector = new Injector( dependencyFactory, mapper, injectionFactory, reflector );
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
      mapper.map( Apple ).to( Apple );
      
      var obj:Object = injector.inject( Apple );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is an Apple", obj is Apple );
    }
    
    [Test]
    public function canCreateWithPropertyDependency():void
    {
      mapper.map( Car ).to( Car );
      mapper.map( Engine ).to( Engine );
      
      var obj:Object = injector.inject( Car );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is an Car", obj is Car );
      
      var car:Car = Car( obj );
      Assert.assertNotNull( "Car has an Engine", car.engine );
    }
    
    [Test]
    public function canInjectViaMethod():void
    {
      mapper.map( Ground ).to( Ground );
      mapper.map( Engine ).to( Engine );
      mapper.map( Apple ).to( Apple );
      mapper.map( Car ).to( Car );
      
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
      mapper.map( Engine ).to( Engine );
      
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
      mapper.map( Table ).to( Table );
      mapper.map( PlantPot ).to( PlantPot );
      
      var obj:Object = injector.inject( Table );
      
      Assert.assertNotNull( obj );
      Assert.assertTrue( "obj is a Table", obj is Table );
      
      var table:Table = Table( obj );
      
      Assert.assertNotNull( table.plantPot );
    }
  }
}



