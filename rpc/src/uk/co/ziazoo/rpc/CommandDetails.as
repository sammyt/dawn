package uk.co.ziazoo.rpc
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class CommandDetails
	{
		public var triggerType:Class;
		public var commandType:Class;

		private var _executeName:String;
		
		public function CommandDetails( commandType:Class )
		{
			var reflection:XML = describeType( commandType );
			var executes:XMLList = reflection.factory..metadata.(@name == "Execute");

			_executeName = executes.parent().@name;
			this.triggerType = getDefinitionByName( executes.parent().parameter.@type ) as Class;
			this.commandType = commandType;
		}
		
		public function invoke( command:Object, notification:IRpcNotification ):void
		{
			var execute:Function = command[ _executeName ] as Function;
			execute.apply( command, [ notification ] );
		}
	}
}