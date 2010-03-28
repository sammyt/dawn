package uk.co.ziazoo.notifier
{
	import flexunit.framework.TestCase;
	
	public class NotificationBusTest extends TestCase
	{
		private var _bus:Notifier;
		
		public function NotificationBusTest(methodName:String=null)
		{
			super( methodName );
		}
		
		override public function setUp():void
		{
			super.setUp();
			_bus = new Notifier();
		}
		
		override public function tearDown():void
		{
			super.tearDown();
			_bus = null;
		}
		
		public function testAddCallBack():void
		{
			var callBack:Function = function():void{};
			
			_bus.addCallback( Array, callBack );
			assertTrue( "there is one callBack", _bus.callbackList.length == 1 );
		}
		
		public function testRemoveOneCallback():void
		{
			var fun:Function = function():void{};
			
			_bus.addCallback( Array, fun );
			assertTrue( "there is one callBack", _bus.callbackList.length == 1 );
			
			_bus.removeCallback( Array, fun );
			assertTrue( "all gone", _bus.callbackList.length == 0 );
		}
		
		public function testRemoveWithListenerRegistation():void
		{
			var fun:Function = function():void{};
			
			var registration:IListenerRegistration = _bus.addCallback( Array, fun );
			assertTrue( "there is one callBack", _bus.callbackList.length == 1 );
			
			registration.remove();
			
			assertTrue( "all gone", _bus.callbackList.length == 0 );
		}
		
		public function testRemoveCorrectFunWithListenerRegistation():void
		{
			var fun1:Function = function():void{};
			var fun2:Function = function():void{};
			
			var registration:IListenerRegistration = _bus.addCallback( Array, fun1 );
			_bus.addCallback( Array, fun2 );
			
			assertTrue( "there are two callBacks", _bus.callbackList.length == 2 );
			
			registration.remove();
			
			assertTrue( "there is one callBack", _bus.callbackList.length == 1 );
			
			assertTrue( "the remaining callback is fun2", fun2 == _bus.callbackList[0].callback );
		}
	}
}