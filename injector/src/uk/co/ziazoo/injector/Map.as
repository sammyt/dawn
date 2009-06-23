package uk.co.ziazoo.injector
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	public class Map implements IMap
	{
		private var _name:String;
		private var _clazz:Class;
		private var _provider:Class;
		private var _singleton:Boolean = false;
		private var _instance:Object;
		private var _accessors:Dictionary;
		
		public function Map( clazz:Class, provider:Class, name:String = null )
		{
			_clazz = clazz;
			_provider = provider;
			_name = name;
			_accessors = new Dictionary();
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