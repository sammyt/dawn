package uk.co.ziazoo.injector.impl
{
  import flash.utils.Dictionary;

  import org.flexunit.Assert;

  public class MetadataReflectionTest
  {
    public var reflector:Reflector;
    
    public function MetadataReflectionTest()
    {
    }
    
    [Before]
    public function setUp():void
    {
      reflector = new Reflector();
    }
    
    [After]
    public function tearDown():void
    {
      reflector = null;
    }
    
    [Test]
    public function reflectNoArgs():void
    {
      var reflect:XML = <metadata name="Inject"/>;
      
      var metadata:Metadata = reflector.parseMetadata( reflect );
      Assert.assertTrue( "named inject", metadata.name == "Inject" );
    }
    
    [Test]
    public function reflectWithArgs():void
    {
      var reflect:XML = <metadata name="Inject">
        <arg key="name" value="fast"/>
        <arg key="thing" value="woo"/>
      </metadata>;
      
      var metadata:Metadata = reflector.parseMetadata( reflect );
      
      Assert.assertTrue( "named inject", metadata.name == "Inject" );
      
      var props:Dictionary = metadata.properties;
      
      Assert.assertTrue( "has prop name", props["name"] == "fast" );
      Assert.assertTrue( "has prop thing", props["thing"] == "woo" );
    }
  }
}