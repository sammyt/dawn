package uk.co.ziazoo.injector.impl
{
  import org.flexunit.Assert;
  import org.flexunit.async.Async;
  
  import flash.display.Loader;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.system.SecurityDomain;
  
  import uk.co.ziazoo.injector.impl.Injector;
  import uk.co.ziazoo.injector.IInjector;
  
  public class InjectorAppDomainTest extends Object
  {
    private const aToC:String = "../../test/AtoC.swf";
    private const dToF:String = "../../test/DtoF.swf";
    
    private var injector:IInjector;
    
	  public function InjectorAppDomainTest()
	  {
	  }	  
	  
	  [Before(async,timeout="250")]
    public function loadAtoC():void 
    {
      var loader:Loader = new Loader();
      
      Async.proceedOnEvent(this, loader.contentLoaderInfo, 
        Event.COMPLETE, 200);
      
      loader.load(new URLRequest(aToC));
      
      injector = Injector.createInjector();
    }
    
    [After]
    public function tearDown():void
    {
      injector = null;
    }
    
	  [Ignore]
	  [Test(async)]
	  public function parentAppDomain():void
	  {
	    var loader2:Loader = new Loader();
	    var domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
	    var loaderContext:LoaderContext = new LoaderContext(false, domain);
	    
	    var asyncHandler:Function = Async.asyncHandler(this, onChildDomainLoaded, 500, 
	      { domain : domain,
	        loader : loader2 });
	        
	    loader2.contentLoaderInfo.addEventListener(Event.INIT, asyncHandler);
	    loader2.load(new URLRequest(dToF), loaderContext);
	  }
	  
	  private function onChildDomainLoaded(event:Event, obj:Object):void
	  {
	    var domain:ApplicationDomain = obj.domain;
	    var loader:Loader = obj.loader;
	    
	    Assert.assertNotNull(domain);
	    
	    var child:IInjector = injector.createChildInjector(domain);
	    
	    var eClass:Class = Class(domain.getDefinition("org.example::E"));
	    Assert.assertNotNull(eClass);
	    
	    var eInstance:Object = child.inject(eClass);
	    Assert.assertNotNull(eInstance);
	  }
  }
}

