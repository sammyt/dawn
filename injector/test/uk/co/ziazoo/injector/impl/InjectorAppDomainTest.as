package uk.co.ziazoo.injector.impl
{
  import flash.display.Loader;
  import flash.events.Event;
  import flash.net.URLLoader;
  import flash.net.URLLoaderDataFormat;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  import org.flexunit.Assert;
  import org.flexunit.async.Async;

  import uk.co.ziazoo.injector.IInjector;

  public class InjectorAppDomainTest extends Object
  {
    private const aToC:String = "../../test/AtoC.swf";
    private const dToF:String = "../../test/DtoF.swf";

    private var injector:IInjector;

    public function InjectorAppDomainTest()
    {
    }

    [Before]
    public function loadAtoC():void
    {
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
      var loader:URLLoader = new URLLoader();
      loader.dataFormat = URLLoaderDataFormat.BINARY;

      var asyncHandler:Function = Async.asyncHandler(this,
              onChildDomainLoaded, 500, loader);

      loader.addEventListener(Event.COMPLETE, asyncHandler);
      loader.load(new URLRequest(dToF));
    }

    private function onChildDomainLoaded(event:Event, obj:Object):void
    {

      var loader:URLLoader = obj as URLLoader;

      Assert.assertNotNull(loader);


      var domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
      var loaderContext:LoaderContext = new LoaderContext(false, domain);

      var nextLoader:Loader = new Loader();

      var asyncHandler:Function = Async.asyncHandler(this,
              onNextDomainLoaded, 500, nextLoader);
      nextLoader.contentLoaderInfo.addEventListener(Event.INIT, asyncHandler);

      nextLoader.loadBytes(loader.data, loaderContext);

    }

    private function onNextDomainLoaded(event:Event, loader:Loader):void
    {
      var domain:ApplicationDomain = loader.contentLoaderInfo
              .applicationDomain;
      var child:IInjector = injector.createChildInjector(domain);

      var eClass:Class = Class(domain.getDefinition("org.example::E"));
      Assert.assertNotNull(eClass);

      var eInstance:Object = child.inject(eClass);
      Assert.assertNotNull(eInstance);
      Assert.assertTrue(eInstance is eClass);
    }
  }
}

