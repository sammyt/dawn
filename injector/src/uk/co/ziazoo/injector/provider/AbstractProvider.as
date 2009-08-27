package uk.co.ziazoo.injector.provider
{
	import flash.utils.Dictionary;

	public class AbstractProvider implements IProvider
	{
		protected var _class:Class;
		protected var _name:String;
		protected var _singleton:Boolean = false;
		protected var _accessors:Dictionary;
		protected var _completionTrigger:String = "";
		protected var _hasDependencies:Boolean;
		
		public function AbstractProvider( clazz:Class )
		{
			_class = clazz;
			_accessors = new Dictionary();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get singleton():Boolean
		{
			return _singleton;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get clazz():Class
		{
			return _class;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get name():String
		{
			return _name;	
		}
		
		/**
		 * @inheritDoc
		 */
		public function asSingleton():IProvider
		{
			_singleton = true;
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function withName( name:String ):IProvider
		{
			_name = name;
			return this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAccessor( name:String, provider:IProvider ):void
		{
			_accessors[ provider ] = name;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAccessor( provider:IProvider ):String
		{
			return _accessors[ provider ] as String;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getInstance():Object
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function invokeGenerator():Object
		{
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get completionTrigger():String
		{
			return _completionTrigger; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function set completionTrigger( value:String ):void
		{
			_completionTrigger = value; 
		}
		
		/**
		 * @inheritDoc
		 */
		public function get hasCompletionTrigger():Boolean
		{
			return _completionTrigger != "";
		}	
		
		/**
		 * @inheritDoc
		 */
		public function onDependenciesInjected():void
		{
			_hasDependencies = true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get hasDependencies():Boolean
		{
			return _hasDependencies; 
		}
	}
}