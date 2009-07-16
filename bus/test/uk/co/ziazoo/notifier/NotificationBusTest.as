package uk.co.ziazoo.notifier
{
	import flexunit.framework.TestCase;
	
	public class NotificationBusTest extends TestCase
	{
		private var bus:NotificationBus;
		
		public function NotificationBusTest(methodName:String=null)
		{
			super( methodName );
		}
		
		override public function setUp():void
		{
			super.setUp();
			bus = new NotificationBus();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			bus = null;
		}
		
		public function testAddHandler():void
		{
			var handler:Object = {};
			assertNull( bus.handlers );
			bus.addHandler( handler );
			assertTrue( "there is one handler", bus.handlers.length == 1 );
		}
		
		public function testRemoveHandler():void
		{
			var handler:Object = {};
			assertNull( bus.handlers );
			bus.addHandler( handler );
			assertTrue( "there is one handler", bus.handlers.length == 1 );
			
			bus.removeHandler( handler );
			assertTrue( "there are no handlers", bus.handlers.length == 0 );
		}
		
		public function testRemoveHandler2():void
		{
			var handler1:Object = {};
			var handler2:Object = {};
			
			assertNull( bus.handlers );
			bus.addHandler( handler1 );
			bus.addHandler( handler2 );
			assertTrue( "there are 2 handlers", bus.handlers.length == 2 );
			
			bus.removeHandler( handler1 );
			assertTrue( "theres now one", bus.handlers.length == 1 );
			assertTrue( "hander2 is the only one left", bus.handlers[0] == handler2 );
		}
		
		public function testAddCallBack():void
		{
			var callBack:Function = function(){};
			assertNull( bus.callbackPairs );
			bus.addCallback( Array, callBack );
			assertTrue( "there is one callBack", bus.callbackPairs.length == 1 );
		}
		
		public function testRemoveCallback():void
		{
			var callBack:Function = function(){};
			assertNull( bus.callbackPairs );
			bus.addCallback( Array, callBack );
			assertTrue( "there is one callBack", bus.callbackPairs.length == 1 );
			
			bus.removeCallback( callBack );
			assertTrue( "all gone", bus.callbackPairs.length == 0 );
		}
	}
}