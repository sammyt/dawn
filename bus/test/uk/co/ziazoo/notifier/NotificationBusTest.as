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
		
		public function testRemoveHandlerWithListenerRegistration():void
		{
			var handler:Object = {};
			assertNull( _bus.handlers );
			var registration:IListenerRegistration = _bus.addHandler( handler );
			assertTrue( "there is one handler", _bus.handlers.length == 1 );
			
			registration.remove();
			
			assertTrue( "there are no handlers", _bus.handlers.length == 0 );
		}
		
		public function testAddCallBack():void
		{
			var callBack:Function = function():void{};
			assertNull( _bus.callbacks );
			
			_bus.addCallback( Array, callBack );
			assertTrue( "there is one callBack", _bus.callbacks.length == 1 );
		}
		
		public function testRemoveOneCallback():void
		{
			var fun:Function = function():void{};
			
			assertNull( _bus.callbacks );
			
			_bus.addCallback( Array, fun );
			assertTrue( "there is one callBack", _bus.callbacks.length == 1 );
			
			_bus.removeCallback( Array, fun );
			assertTrue( "all gone", _bus.callbacks.length == 0 );
		}
		
		public function testRemoveWithListenerRegistation():void
		{
			var fun:Function = function():void{};
			
			assertNull( _bus.callbacks );
			
			var registration:IListenerRegistration = _bus.addCallback( Array, fun );
			assertTrue( "there is one callBack", _bus.callbacks.length == 1 );
			
			registration.remove();
			
			assertTrue( "all gone", _bus.callbacks.length == 0 );
		}
		
		public function testRemoveCorrectFunWithListenerRegistation():void
		{
			var fun1:Function = function():void{};
			var fun2:Function = function():void{};
			
			assertNull( _bus.callbacks );
			
			var registration:IListenerRegistration = _bus.addCallback( Array, fun1 );
			_bus.addCallback( Array, fun2 );
			
			assertTrue( "there are two callBacks", _bus.callbacks.length == 2 );
			
			registration.remove();
			
			assertTrue( "there is one callBack", _bus.callbacks.length == 1 );
			
			assertTrue( "the remaining callback is fun2", fun2 == _bus.callbacks[0].callback );
		}
	}
}