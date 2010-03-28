package uk.co.ziazoo.notifier
{
  import org.flexunit.Assert;

  public class NotifierTest
  {
    private var notifier:Notifier;

    public function NotifierTest()
    {
    }
    
    [Before]
    public function setUp():void
    {
      notifier = new Notifier();
    }

    [After]
    public function tearDown():void
    {
      notifier = null;
    }
  
    [Test]
    public function testAddCallBack():void
    {
      var invokeCount:int = 0;
      var callBack:Function = 
        function(...args):void{
          invokeCount++;
        };

      var returned:Function = notifier.add(Object, callBack);
      
      Assert.assertTrue("got right listener back", callBack == returned);
      
      notifier.trigger(new Object());
      Assert.assertTrue("triggered once", invokeCount == 1);
      
      notifier.trigger([]);
      Assert.assertTrue("triggered once", invokeCount == 1);
    }
    
    [Test]
    public function testAddPolymorphicCallBack():void
    {
      var invokeCount:int = 0;
      var callBack:Function = 
        function(...args):void{
          invokeCount++;
        };
      
      var returned:Function = notifier.add(Object, callBack, true);
      Assert.assertTrue("got right listener back", callBack == returned);
      
      notifier.trigger(new Object());
      Assert.assertTrue("triggered once", invokeCount == 1);
      
      notifier.trigger([]);
      Assert.assertTrue("triggered again", invokeCount == 2);
    }
    
    [Test]
    public function sendsCorrectPayload():void
    {
      var payLoad:Array = ["woo"];
      
      var invokeCount:int = 0;
      var callBack:Function = 
        function(note:Array):void{
          Assert.assertTrue( "got correct payload", payLoad == note);
          invokeCount++;
        };
      
      notifier.add(Array, callBack);
      
      notifier.trigger(new Object());
      Assert.assertTrue("not triggered", invokeCount == 0);
      
      notifier.trigger(payLoad);
      Assert.assertTrue("triggered", invokeCount == 1);
    }
    
    [Test]
    public function canRemoveCallback():void
    {
      var invokeCount:int = 0;
      
      var callBack:Function = 
        function(...args):void{
          invokeCount++;
        };
      
      notifier.add(String, callBack);
      notifier.trigger("wibble");
      Assert.assertTrue("triggered", invokeCount == 1);
      
      notifier.remove(String, callBack);
      notifier.trigger("wibble");
      Assert.assertTrue("not triggered again", invokeCount == 1);
    }
    
    [Test]
    public function canRemovePolymorphicCallback():void
    {
      var invokeCount:int = 0;
      
      var callBack:Function = 
        function(...args):void{
          invokeCount++;
        };
      
      notifier.add(String, callBack, true);
      notifier.trigger("wibble");
      Assert.assertTrue("triggered", invokeCount == 1);
      
      notifier.remove(String, callBack);
      notifier.trigger("wibble");
      Assert.assertTrue("not triggered again", invokeCount == 1);
    }
  }
}