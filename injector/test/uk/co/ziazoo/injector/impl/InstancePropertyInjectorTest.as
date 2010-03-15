package uk.co.ziazoo.injector.impl
{	
  import org.flexunit.*;
  import some.thing.*;
  
  public class InstancePropertyInjectorTest
  {
    public function InstancePropertyInjectorTest()
    {
    }
    
    [Test]
    public function doesInject():void
    {
      var instance:Tree = new Tree( new Ground() );
      
      var injector:InstancePropertyInjector = 
        new InstancePropertyInjector( "thing", new Engine() );
      
      injector.inject( instance );
      
      Assert.assertNotNull( "has a engine", instance.thing );
    }
  }
}