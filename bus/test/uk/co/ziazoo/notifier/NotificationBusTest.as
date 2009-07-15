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
	}
}