package uk.co.ziazoo
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class NotificationBus implements INotificationBus
	{
		protected var _classMap:Dictionary;
		protected var _handlers:Array;
		
		public function NotificationBus()
		{
		}
		
		public function map(notification:Class, responder:Class):void
		{
			classMap[ notification ] = responder;
		}
		
		public function addHandler( handler:Object ):void
		{
			handlers.push( handler );
		}
		
		public function trigger(worker:Object):void
		{
			var name:String = getQualifiedClassName( worker );
			var triggerClass:Class = getDefinitionByName( name ) as Class; 
			var handlerClass:Class = classMap[ triggerClass ] as Class;
		
			if( handlerClass )
			{
				for each( var handler:Object in handlers )
				{
					if( handler is handlerClass )
					{
						// need to know what method to call on the worker
						getWorkerInjectorMethod( worker ).apply( worker, [ handler ] );
					}
				}
			}		 
		}
		
		public function getWorkerInjectorMethod( worker:Object ):Function
		{
			var reflection:XML = describeType( worker );
			var methodName:String = reflection.method.(metadata.@name=="InjectHandler").@name;
			return worker[methodName];
		}
		
		protected function get classMap():Dictionary
		{
			if( !_classMap )
			{
				_classMap = new Dictionary();
			}
			return _classMap;
		}
		
		protected function get handlers():Array
		{
			if( !_handlers )
			{
				_handlers = new Array();
			}
			return _handlers;
		}
	}
}