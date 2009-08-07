package uk.co.ziazoo.injector.providers
{
	import flash.utils.Dictionary;

	public class AbstractProvider implements IProvider
	{
		protected var _class:Class;
		protected var _name:String;
		protected var _singleton:Boolean = false;
		protected var _accessors:Dictionary;
		protected var _completionTrigger:String = "";
		
		public function AbstractProvider( clazz:Class )
		{
			_class = clazz;
			_accessors = new Dictionary();
		}
		
		public function get singleton():Boolean
		{
			return _singleton;
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
		
		public function addAccessor( name:String, provider:IProvider ):void
		{
			_accessors[ provider ] = name;
		}
		
		public function getAccessor( provider:IProvider ):String
		{
			return _accessors[ provider ] as String;
		}
		
		public function createInstance():Object
		{
			return null;
		}
		
		public function invokeGenerator():Object
		{
			return null;
		}
		
		public function get completionTrigger():String
		{
			return _completionTrigger; 
		}
		
		public function set completionTrigger( value:String ):void
		{
			_completionTrigger = value; 
		}
		
		public function hasCompletionTrigger():Boolean
		{
			return _completionTrigger != "";
		}
	}
}