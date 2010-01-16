package uk.co.ziazoo.command
{
	import flexunit.framework.Assert;
	
	public class CommandTest
	{		
		[Test]
		public function getsMethodName():void
		{
			var command:Command = new Command( MockCommand );
			Assert.assertEquals( "name is doIt", "doIt", command.getMethodName() );
		}
		
		[Test]
		public function getsCommandType():void
		{
			var command:Command = new Command( MockCommand );
			Assert.assertEquals( "Type is MockCommand", MockCommand, command.commandType );
		}
		
		[Test]
		public function getsTriggerType():void
		{
			var command:Command = new Command( MockCommand );
			Assert.assertEquals( "Type is MockCommand", String, command.triggerType );
		}
		
		[Test]
		public function invoke():void
		{
			var command:Command = new Command( MockCommand );
			
			var mock:MockCommand = new MockCommand();
			
			Assert.assertEquals( "doIt no called", 0, mock.invokeCount );
			
			command.invoke( mock, "" );
			
			Assert.assertEquals( "doIt has been called", 1, mock.invokeCount );
		}
	}
}

class MockCommand {
	
	public var invokeCount:int = 0;
	
	[Execute]
	public function doIt( note:String ):void
	{
		invokeCount ++;
	}
}