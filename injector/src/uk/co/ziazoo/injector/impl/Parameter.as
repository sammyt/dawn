package uk.co.ziazoo.injector.impl
{	
	public class Parameter
	{
		public var index:int;
		public var type:String;
		public var optional:Boolean;
		
		public function Parameter( reflection:XML )
		{
			index = parseInt( reflection.@index );
			type = reflection.@type;
			optional = reflection.@optional == "true";
		}
	}
}