package uk.co.ziazoo.injector.impl 
{
  import org.flexunit.Assert;
  
  import some.thing.*;
  
  import uk.co.ziazoo.injector.*;
  
  public class InjectionPointFactoryTest
  {
    private var factory:InjectionPointFactory;
    
    public function InjectionPointFactoryTest()
    {
    }
    
    [Before]
    public function setUp():void
    {
      var mapper:IMapper = new Mapper( null );
      
      factory = new InjectionPointFactory( 
        new DependencyFactory(), mapper );
    }
    
    [After]
    public function tearDown():void
    {
      factory = null;
    }
    
    public function createMethod():Method
    {
      var method:Method = new Method();
      method.name = "injectLeaf";
      
      var leaf:Parameter = new Parameter();
      leaf.type = "some.thing::Leaf";
      leaf.index = 1;
      leaf.optional = false;
      
      method.addParameter( leaf );
      
      var metadata:Metadata = new Metadata();
      metadata.name = "Inject";
      
      method.addMetadata( metadata );
      
      return method;
    }
    
    public function createProperty():Property
    {
      var property:Property = new Property();
      property.name = "car";
      property.type = "some.thing::Car";
      
      var metadata:Metadata = new Metadata();
      metadata.name = "Inject";
      metadata.addProperty( "name", "fast" );
      property.addMetadata( metadata );
      
      return property;
    }
    
    public function createConstructor():Constructor
    {
      var constructor:Constructor = new Constructor();
      
      var inject:Metadata = new Metadata();
      inject.name = "Inject";
      constructor.addMetadata( inject );
      
      var named:Metadata = new Metadata();
      named.name = "Inject";
      named.addProperty( "arg", "ground" );
      named.addProperty( "name", "earth" );
      constructor.addMetadata( named );
      
      var parameter:Parameter = new Parameter();
      parameter.index = 1;
      parameter.type = "some.thing::Ground";
      parameter.optional = false;
      
      constructor.addParameter( parameter );
      
      return constructor;
    }
    
    [Test]
    public function getInjectionForMethod():void
    {
      var injectionPoint:IInjectionPoint = factory.forMethod( createMethod() );
      Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
      
      var deps:Array = injectionPoint.getDependencies();
      Assert.assertTrue( "has one dep", 1 == deps.length );
    }
    
    [Test]
    public function getInjectionForProperty():void
    {	
      var injectionPoint:IInjectionPoint = 
        factory.forProperty( createProperty() );
      
      Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
      
      var deps:Array = injectionPoint.getDependencies();
      Assert.assertTrue( "has one deps", 1 == deps.length );
    }
    
    [Test]
    public function getInjectionForConstructor():void
    {
      var injectionPoint:IInjectionPoint = 
        factory.forConstructor( createConstructor() );
      
      Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
      
      var deps:Array = injectionPoint.getDependencies();
      Assert.assertTrue( "has one deps", 1 == deps.length );
    }
  }
}

