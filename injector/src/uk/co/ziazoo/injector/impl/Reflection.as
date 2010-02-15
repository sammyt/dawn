package uk.co.ziazoo.injector.impl 
{
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	
	internal class Reflection 
	{
		public var type:Class;
		public var properties:Array;
		public var methods:Array;
		public var constructor:Constructor;
		
		public function Reflection()
		{
		}
		
		public function addProperty( property:Property ):void
		{
			if( !properties )
			{
				properties = [];
			}
			properties.push( property );
		}
		
		public function addMethod( method:Method ):void
		{
			if( !methods )
			{
				methods = [];
			}
			methods.push( method );
		}
	}
}
