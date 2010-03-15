package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  
  public class ParameterReflectionTest
  {
    public var reflector:Reflector;
    
    public function ParameterReflectionTest()
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
    public function simpleParam():void
    {
      var reflection:XML = 
        <parameter index="1" type="some.thing::Leaf" optional="false"/>;
      
      var param:Parameter = reflector.parseParameter( reflection );
      
      Assert.assertTrue( "gets index", param.index == 1 );
      Assert.assertTrue( "gets type", param.type == "some.thing::Leaf" );
      Assert.assertTrue( "gets index", param.optional == false );
    }
  }
}