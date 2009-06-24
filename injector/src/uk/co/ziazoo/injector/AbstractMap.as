package uk.co.ziazoo.injector
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	public class AbstractMap implements IMap
	{
		protected var _name:String;
		protected var _clazz:Class;
		protected var _provider:Class;
		protected var _singleton:Boolean = false;
		protected var _accessors:Dictionary;
		protected var _isGenerator:Boolean;
		protected var _instance:Object;
		
		public function AbstractMap()
		{
		}
		
		public function get isProviderFactory():Boolean
		{
			return _isGenerator;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get clazz():Class
		{
			return _clazz;
		}
		
		public function get provider():Class
		{
			return _provider;
		}
		
		public function get clazzName():String
		{
			return getQualifiedClassName( _clazz );
		}
		
		public function get providerName():String
		{
			return getQualifiedClassName( _provider );
		}
		
		public function get singleton():Boolean
		{
			return _singleton;
		}
		
		public function set singleton( value:Boolean ):void
		{
			_singleton = value;
		}
		
		public function provideInstance():Object
		{
			if( singleton && _instance )
			{
				return _instance;
			}
			else if( singleton )
			{
				_instance = new _provider();
				return _instance;
			}
			
			return new _provider();
		}
		
		public function addAccessor( name:String, clazzName:String ):void
		{
			_accessors[ clazzName ] = name;
		}
		
		public function getAccessor( clazzName:String ):String
		{
			return _accessors[ clazzName ] as String;
		}
		
		public function toString():String
		{
			return "[Map provider=" + _provider + "]";
		}
	}
}