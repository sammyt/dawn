package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IProvider;
	
	public class Mapping implements IMapping
	{
		private var _type:Class;
		private var _name:String;
		private var _provider:IProvider;
		
		public function Mapping( type:Class )
		{
			_type = type;
			_name = "";
		}
		
		public function get type():Class
		{
			return _type;
		}
		
		public function get provider():IProvider
		{
			return _provider;
		}
		
		public function set provider(value:IProvider):void 
		{
			_provider = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
	}
}

