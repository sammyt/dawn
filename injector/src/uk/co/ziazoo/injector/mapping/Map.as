package uk.co.ziazoo.injector.mapping
{
	import uk.co.ziazoo.injector.provider.BasicProvider;
	import uk.co.ziazoo.injector.provider.FactoryProvider;
	import uk.co.ziazoo.injector.provider.IProvider;
	import uk.co.ziazoo.injector.provider.InstanceProvider;

	public class Map implements IMap
	{
		private var _clazz:Class;
		private var _provider:IProvider;
		
		public function Map( clazz:Class )
		{
			_clazz = clazz;
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function get clazz():Class
		{
			return _clazz;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toClass( clazz:Class ):IProvider
		{
			_provider = new BasicProvider( clazz ); 
			return _provider;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toFactory( factory:Class ):IProvider
		{
			_provider = new FactoryProvider( factory );
			return _provider;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toInstance( object:Object ):IProvider
		{
			_provider = new InstanceProvider( object );
			return _provider;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toSelf():IProvider
		{
			return toClass( _clazz );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get provider():IProvider
		{
			return _provider;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isFactory():Boolean
		{
			return _provider is FactoryProvider;
		}
		
		public function toString():String
		{
			return "[Map=" + clazz + ", provider="+ provider.clazz +"]";
		}
	}
}