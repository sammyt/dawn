package uk.co.ziazoo.injector.impl
{	
	public class Parameter
	{
		public var name:String
		public var index:int;
		public var type:String;
		public var optional:Boolean;
		
		public function Parameter( reflection:XML )
		{
			name = reflection.@name;
			index = parseInt( reflection.@index );
			type = reflection.@type;
			optional = reflection.@optional == "true";
		}
	}
}