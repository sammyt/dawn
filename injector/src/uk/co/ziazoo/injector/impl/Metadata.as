package uk.co.ziazoo.injector.impl
{	
	import flash.utils.Dictionary;
	
	public class Metadata
	{
		public var name:String;
		public var properties:Dictionary;
		
		public function Metadata()
		{
		}
		
		public function addProperty( name:String, value:String ):void
		{
			if( !properties )
			{
				properties = new Dictionary();
			}
			properties[ name ] = value;
		}
	}
}