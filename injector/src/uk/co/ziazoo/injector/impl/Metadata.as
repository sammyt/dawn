package uk.co.ziazoo.injector.impl
{	
	import flash.utils.Dictionary;
	
	public class Metadata
	{
		public var name:String;
		public var properties:Dictionary;
		
		public function Metadata( reflect:XML )
		{
			name = reflect.@name;
			properties = new Dictionary();
			for each( var p:XML in reflect.arg )
			{
				properties[ String(p.@key) ] = String(p.@value);
			}
		}
	}
}