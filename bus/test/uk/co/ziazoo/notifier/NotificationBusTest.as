package uk.co.ziazoo.notifier
{
	import flexunit.framework.TestCase;
	
	public class NotificationBusTest extends TestCase
	{
		private var _bus:NotificationBus;
		
		public function NotificationBusTest(methodName:String=null)
		{
			super( methodName );
		}
		
		override public function setUp():void
		{
			super.setUp();
			_bus = new NotificationBus();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			_bus = null;
		}
		
		public function testAddHandler():void
		{
			var handler:Object = {};
			assertNull( _bus.handlers );
			_bus.addHandler( handler );
			assertTrue( "there is one handler", _bus.handlers.length == 1 );
		}
		
		public function testRemoveHandler():void
		{
			var handler:Object = {};
			assertNull( _bus.handlers );
			_bus.addHandler( handler );
			assertTrue( "there is one handler", _bus.handlers.length == 1 );
			
			_bus.removeHandler( handler );
			assertTrue( "there are no handlers", _bus.handlers.length == 0 );
		}
		
		public function testRemoveOneCallback():void
		{
			var fun:Function = function(){};
				assertNull( _bus.callbackPairs );
			_bus.addCallback( Array, fun );
			assertTrue( "there is one callBack", _bus.callbackPairs.length == 1 );
			
			_bus.removeCallback( fun );
			assertTrue( "all gone", _bus.callbackPairs.length == 0 );
		}
		
		public function testAddCallBack():void
		{
			var callBack:Function = function(){};
			assertNull( _bus.callbackPairs );
			_bus.addCallback( Array, callBack );
			assertTrue( "there is one callBack", _bus.callbackPairs.length == 1 );
		}
	}
}