package uk.co.ziazoo.injector.providers
{
	import uk.co.ziazoo.injector.IProvider;
	
	public class AbstractProvider implements IProvider
	{
		private var _class:Class;
		private var _name:String;
		private var _singleton:Boolean = false;
		
		public function AbstractProvider( clazz:Class )
		{
			_class = clazz;
		}
		
		public function get clazz():Class
		{
			return _class;
		}
		
		public function get name():String
		{
			return _name;	
		}
		
		public function asSingleton():IProvider
		{
			_singleton = true;
			return this;
		}
		
		public function withName( name:String ):IProvider
		{
			_name = name;
			return this;
		}
	}
}