package uk.co.ziazoo.injector
{
	import uk.co.ziazoo.injector.providers.BasicProvider;
	import uk.co.ziazoo.injector.providers.FactoryProvider;
	import uk.co.ziazoo.injector.providers.IProvider;

	public class Map implements IMap
	{
		private var _clazz:Class;
		private var _provider:IProvider;
		
		public function Map( clazz:Class )
		{
			_clazz = clazz;
		}
		
		public function get clazz():Class
		{
			return _clazz;
		}
		
		public function toClass( clazz:Class ):IProvider
		{
			_provider = new BasicProvider( clazz ); 
			return _provider;
		}
		
		public function toFactory( factory:Class ):IProvider
		{
			_provider = new FactoryProvider( factory );
			return _provider;
		}
		
		public function toSelf():IProvider
		{
			return toClass( _clazz );
		}
		
		public function get provider():IProvider
		{
			return _provider;
		}
		
		public function toString():String
		{
			return "[Map " + clazz + "]";
		}
	}
}