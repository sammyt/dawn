package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  import org.flexunit.asserts.assertTrue;

  import some.otherthing.*;
  import some.thing.Apple;
  import some.thing.BigEngine;
  import some.thing.Car;
  import some.thing.CarWithTwoRadios;
  import some.thing.EagerBunny;
  import some.thing.Ground;
  import some.thing.IRadio;
  import some.thing.LittleEngine;
  import some.thing.LoudRadio;
  import some.thing.PlantPot;
  import some.thing.PlantPotFactory;
  import some.thing.QuietRadio;
  import some.thing.Table;
  import some.thing.Wibble;

  import uk.co.ziazoo.fussy.Fussy;
  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

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
      var eagerQueue:IEagerQueue = new EagerQueue();
      var detailsFactory:ITypeInjectionDetailsFactory =
        new FussyTypeDetailsFactory(new Fussy().query());
      mapper = new Mapper(new MappingBuilderFactory(eagerQueue, detailsFactory));

      injector = new Injector(mapper, eagerQueue, detailsFactory);
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
      var obj:Object = injector.inject(Apple);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is an Apple", obj is Apple);
    }

    [Test]
    public function canCreateWithPropertyDependency():void
    {
      var obj:Object = injector.inject(Car);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is an Car", obj is Car);

      var car:Car = Car(obj);
      Assert.assertNotNull("Car has an Engine", car.engine);
    }

    [Test]
    public function canInjectViaMethod():void
    {
      var obj:Object = injector.inject(Ground);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is a Ground", obj is Ground);

      var ground:Ground = Ground(obj);

      Assert.assertNotNull(ground.apple);
      Assert.assertNotNull(ground.car);
      Assert.assertNotNull(ground.engine);
    }

    [Test]
    public function injectionsWithNames():void
    {
      mapper.map(Car).to(CarWithTwoRadios);
      mapper.map(IRadio).to(LoudRadio).named("loud radio");
      mapper.map(IRadio).to(QuietRadio);

      var obj:Object = injector.inject(Car);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is a CarWithTwoRadios", obj is CarWithTwoRadios);

      var car:CarWithTwoRadios = CarWithTwoRadios(obj);

      Assert.assertNotNull(car.engine);
      Assert.assertNotNull(car.loudRadio);
      Assert.assertNotNull(car.radio);

      assertTrue("has correct IRadio", car.loudRadio is LoudRadio);
    }

    [Test]
    public function injectionsByConstructor():void
    {
      var obj:Object = injector.inject(Table);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is a Table", obj is Table);

      var table:Table = Table(obj);

      Assert.assertNotNull(table.plantPot);
    }

    [Test]
    public function factoryInjection():void
    {
      mapper.map(PlantPot).toFactory(PlantPotFactory);

      var obj:Object = injector.inject(Table);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is a Table", obj is Table);

      var table:Table = Table(obj);

      Assert.assertNotNull(table.plantPot);
    }

    [Test]
    public function instanceInjection():void
    {
      var pot:PlantPot = new PlantPot();
      mapper.map(PlantPot).toInstance(pot);

      var obj:Object = injector.inject(Table);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is a Table", obj is Table);

      var table:Table = Table(obj);

      Assert.assertNotNull(table.plantPot);
      Assert.assertTrue("has correct instance", table.plantPot == pot);
    }

    [Test]
    public function singletonScoping():void
    {
      mapper.map(Apple).asSingleton();

      var obj:Object = injector.inject(Apple);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is an Apple", obj is Apple);

      Assert.assertTrue("same instance returned", obj ==
        injector.inject(Apple));
    }

    [Test]
    public function injectNamedViaConstructor():void
    {
      var granny:Apple = new Apple();
      mapper.map(Apple);
      mapper.map(Apple).named("granny").toInstance(granny);
      mapper.map(IRadio).named("loud").to(QuietRadio);


      var obj:Object = injector.inject(Wibble);
      Assert.assertTrue("obj is a Wibble", obj is Wibble);

      var wibble:Wibble = Wibble(obj);

      Assert.assertTrue("has the right apple", wibble.apple == granny);
    }

    [Test]
    public function injectNamedInInjectSyntax():void
    {
      mapper.map(IRadio).to(QuietRadio);
      mapper.map(IRadio).to(LoudRadio).named("loud");

      var obj:Object = injector.inject(Wibble);
      Assert.assertTrue("obj is a Wibble", obj is Wibble);

      var wibble:Wibble = Wibble(obj);

      Assert.assertTrue("has the right radio", wibble.radio is LoudRadio);
    }

    [Test]
    public function createBikeWithContreteConstructorArg():void
    {
      injector.map(IDial).to(DigitalDial);
      injector.map(IDial).named("analog").to(AnalogDial);
      injector.map(String).named("bike name").toInstance("my bike");

      var bike:SlowBike = SlowBike(injector.inject(SlowBike));

      Assert.assertTrue("engine is slow engine", bike.engine is SlowBikeEngine);
      Assert.assertNotNull(bike.dial);
      Assert.assertTrue("dial is analog", bike.dial is AnalogDial);
      Assert.assertTrue("gets the name", bike.name == "my bike");
    }

    [Test]
    public function doesPostConstructGetCalled():void
    {
      var engine:SlowBikeEngine = SlowBikeEngine(
        injector.inject(SlowBikeEngine));
      Assert.assertTrue("PostConstruct method called", engine.invokeCount == 1);
    }

    [Test]
    public function createEagerSingletons():void
    {
      injector.map(EagerBunny).asEagerSingleton();

      injector.inject(PlantPot);

      Assert.assertTrue("EagerBunny was created", EagerBunny.createCount == 1);
    }

    [Test]
    public function usingAndMapping():void
    {
      injector.map(IBikeEngine).and(SlowBikeEngine).to(SlowBikeEngine);

      var thing:ThingWithTwoEngines =
        ThingWithTwoEngines(injector.inject(ThingWithTwoEngines));


      Assert.assertNotNull(thing.engine1);
      Assert.assertNotNull(thing.engine2);

      Assert.assertTrue("both SlowBikeEngine", thing.engine1 is SlowBikeEngine);
      Assert.assertTrue("both SlowBikeEngine", thing.engine2 is SlowBikeEngine);
    }

    [Test]
    public function usingAndMappingInSingletonScope():void
    {
      injector.map(IBikeEngine).and(SlowBikeEngine).to(
        ReallySlowBikeEngine).asSingleton();

      var thing:ThingWithTwoEngines =
        ThingWithTwoEngines(injector.inject(ThingWithTwoEngines));


      Assert.assertNotNull(thing.engine1);
      Assert.assertNotNull(thing.engine2);

      Assert.assertTrue("both SlowBikeEngine",
        thing.engine1 is ReallySlowBikeEngine);

      Assert.assertTrue("both SlowBikeEngine",
        thing.engine2 is ReallySlowBikeEngine);

      Assert.assertTrue("same instance", thing.engine1 == thing.engine2);
    }

    [Test]
    public function usingManyAnds():void
    {
      injector.map(IBikeEngine).and(SlowBikeEngine).and(
        ReallySlowBikeEngine).to(ReallySlowBikeEngine).asSingleton();

      var thing:ThingWithThreeEngines =
        ThingWithThreeEngines(injector.inject(ThingWithThreeEngines));

      Assert.assertTrue("is SlowBikeEngine",
        thing.engine1 is ReallySlowBikeEngine);

      Assert.assertTrue("is SlowBikeEngine",
        thing.engine2 is ReallySlowBikeEngine);

      Assert.assertTrue("is SlowBikeEngine",
        thing.engine3 is ReallySlowBikeEngine);

      Assert.assertNotNull(thing.engine1);
      Assert.assertNotNull(thing.engine2);
      Assert.assertNotNull(thing.engine3);

      Assert.assertTrue("same instance 1-2", thing.engine1 ==
        thing.engine2);

      Assert.assertTrue("same instance 2-3", thing.engine2 ==
        thing.engine3);
    }

    [Test]
    public function injectsProvidedInstance():void
    {
      var instance:Car = new Car();

      var obj:Object = injector.inject(instance);

      Assert.assertNotNull(obj);
      Assert.assertTrue("obj is an Car", obj is Car);
      Assert.assertTrue("obj is instance", obj == instance);
      Assert.assertNotNull("Car has an Engine", instance.engine);
    }

    [Test]
    public function childInjectorCreation():void
    {
      var child:IInjector = injector.createChildInjector();
      Assert.assertNotNull(child);
      Assert.assertNotNull(child.parent);
      Assert.assertTrue(child.parent == injector);
      Assert.assertTrue(child != injector);
    }

    [Test]
    public function mappingFilterDown():void
    {
      injector.map(IDial).to(DigitalDial);
      injector.map(IDial).named("analog").to(AnalogDial);
      injector.map(String).named("bike name").toInstance("my bike");

      var child:IInjector = injector.createChildInjector();

      Assert.assertNotNull(child.getMapping(IDial));

      var fromParent:IMapping = injector.getMapping(IDial, "analog");
      var fromChild:IMapping = child.getMapping(IDial, "analog");

      Assert.assertTrue(fromChild == fromParent);
    }


    [Test]
    public function childMappingArePrivateFromParent():void
    {
      var child:IInjector = injector.createChildInjector();

      child.map(IDial).named("analog").to(AnalogDial);

      var fromParent:IMapping = injector.getMapping(IDial, "analog");
      var fromChild:IMapping = child.getMapping(IDial, "analog");

      Assert.assertNotNull(fromChild);
      Assert.assertNotNull(fromParent);
      Assert.assertFalse(fromChild == fromParent);
      Assert.assertTrue(fromParent.isJustInTime);
      Assert.assertFalse(fromChild.isJustInTime);
    }

    [Test]
    public function mappingFilterDownManyLayers():void
    {
      injector.map(IDial).to(DigitalDial);
      injector.map(IDial).named("analog").to(AnalogDial);
      injector.map(String).named("bike name").toInstance("my bike");

      var child:IInjector = injector.createChildInjector();
      var grandChild:IInjector = child.createChildInjector();

      Assert.assertNotNull(child.getMapping(IDial));
      Assert.assertNotNull(grandChild.getMapping(IDial));

      var fromParent:IMapping = injector.getMapping(IDial, "analog");
      var fromChild:IMapping = child.getMapping(IDial, "analog");
      var fromGrandChild:IMapping = grandChild.getMapping(IDial, "analog");

      Assert.assertTrue(fromChild == fromParent);
      Assert.assertTrue(fromChild == fromGrandChild);
    }

    [Test]
    public function usingPrivateConfig():void
    {
      injector.installPrivate(new BigCarConfig());
      injector.installPrivate(new LittleCarConfig());

      var car:Car = Car(injector.inject(Car));
      var bigCar:Car = Car(injector.inject(Car, "Big"));
      var littleCar:Car = Car(injector.inject(Car, "Little"));

      Assert.assertNotNull(car);

      Assert.assertNotNull(bigCar);
      Assert.assertNotNull(bigCar.engine);
      Assert.assertTrue(bigCar.engine is BigEngine);

      Assert.assertNotNull(littleCar);
      Assert.assertNotNull(littleCar.engine);
      Assert.assertTrue(littleCar.engine is LittleEngine);

      var littleEngine:LittleEngine = LittleEngine(littleCar.engine);

      Assert.assertTrue(littleEngine.cylinders == 4);
    }

    [Test]
    [Ignore]
    public function throwsNoMappingError():void
    {
      injector.inject(Wibble);
    }
  }
}

import some.thing.BigEngine;
import some.thing.Car;
import some.thing.Engine;
import some.thing.LittleEngine;

import uk.co.ziazoo.injector.IPrivateConfiguration;
import uk.co.ziazoo.injector.IPrivateMapper;

class BigCarConfig implements IPrivateConfiguration
{
  public function configure(mapper:IPrivateMapper):void
  {
    mapper.map(Engine).to(BigEngine);
    mapper.expose(Car, "Big");
  }
}

class LittleCarConfig implements IPrivateConfiguration
{
  public function configure(mapper:IPrivateMapper):void
  {
    mapper.map(Engine).to(LittleEngine);
    mapper.map(int).named("cylinder count").toInstance(4);
    mapper.expose(Car, "Little");
  }
}
