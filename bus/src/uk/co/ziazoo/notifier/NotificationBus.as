package uk.co.ziazoo.notifier
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class NotificationBus implements INotificationBus
	{	
		protected var _handlers:Array;
		protected var _workerHandlerMap:Dictionary;
		
		public function NotificationBus()
		{
		}
		
		public function addHandler( handler:Object ):void
		{
			if( !_handlers )
			{
				_handlers = new Array();
			}
			_handlers.push( handler );
		}
		
		public function removeHandler( handler:Object ):void
		{
			var index:int = 0;
			for each( var current:Object in _handlers )
			{
				if( current == handler )
				{
					_handlers = _handlers.splice( index, 1 );
					return;
				}
				index++;
			}
		}
		
		public function trigger( worker:Object ):void
		{
			var workerClass:String = getQualifiedClassName( worker );
			var workerDetails:WorkerDetails;
			
			if( !_workerHandlerMap )
			{
				_workerHandlerMap = new Dictionary();
			}
			
			if( _workerHandlerMap[ workerClass ] )
			{
				workerDetails = _workerHandlerMap[ workerClass ] as WorkerDetails;
			}
			else
			{
				workerDetails = new WorkerDetails( worker );
				_workerHandlerMap[ workerClass ] = workerDetails;
			}
			
			var injector:Function = worker[ workerDetails.methodName ] as Function;
			
			for each( var handler:Object in _handlers )
			{
				if( handler is workerDetails.handlerType )
				{
					injector.apply( worker, [ handler ] );
				}
			}
		}
	}
}

import flash.utils.describeType;
import flash.utils.getDefinitionByName;

class WorkerDetails
{
	public var methodName:String;
	public var handlerType:Class;
	
	public function WorkerDetails( worker:Object )
	{
		var reflection:XML = describeType( worker );
		var node:XMLList = reflection..metadata.(@name == "InjectHandler");
		methodName = node.parent().@name;
		handlerType = getDefinitionByName( node.parent().parameter.@type ) as Class;
	}
}








