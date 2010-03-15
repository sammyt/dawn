package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  
  public class MethodReflectionTest
  {
    public var reflector:Reflector;
    
    public function MethodReflectionTest()
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
    public function hasParams():void
    {
      var reflect:XML = <method name="injectLeaf" 
        declaredBy="some.thing::Tree" returnType="void">
        <parameter index="1" type="some.thing::Leaf" optional="false"/>
        <metadata name="Inject"/>
      </method>;
      
      var method:Method = reflector.parseMethod( reflect );
      
      Assert.assertTrue( "name of injectLeaf", method.name == "injectLeaf" );
      Assert.assertTrue( "one param", method.params.length == 1 );
      Assert.assertTrue( "one metadata", method.metadatas.length == 1 );
    }
  }
}