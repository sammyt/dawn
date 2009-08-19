package uk.co.ziazoo.notifier
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class NotificationBus implements INotificationBus
	{	
		protected var _handlers:Array;
		protected var _callbackPairs:Array;
		protected var _notificationDetailsMap:Dictionary;
		
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
					_handlers.splice( index, 1 );
					return;
				}
				index++;
			}
		}
		
		public function addCallback( notificationType:Class, callback:Function ):void
		{
			if( !_callbackPairs )
			{
				_callbackPairs = new Array();
			}
			_callbackPairs.push( new CallbackTypePair( callback, notificationType ) );
		}
		
		public function removeCallback( notificationType:Class, callback:Function ):void
		{
			var index:int = 0;
			for each( var current:CallbackTypePair in _callbackPairs )
			{
				if( current.type == notificationType
				 	&& current.callback == callback )
				{
					_callbackPairs.splice( index, 1 );
					return;
				}
				index++;
			}
		}
		
		public function trigger( notification:Object ):void
		{
			var notificationClass:String = getQualifiedClassName( notification );
			var notificationDetails:NotificationDetails;
			
			if( !_notificationDetailsMap )
			{
				_notificationDetailsMap = new Dictionary();
			}
			
			if( _notificationDetailsMap[ notificationClass ] )
			{
				notificationDetails = _notificationDetailsMap[ notificationClass ] as NotificationDetails;
			}
			else
			{
				notificationDetails = new NotificationDetails( notification );
				_notificationDetailsMap[ notificationClass ] = notificationDetails;
			}
			
			if( notificationDetails.methodName )
			{
				var injector:Function = notification[ notificationDetails.methodName ] as Function;
				
				for each( var handler:Object in _handlers )
				{
					if( handler is notificationDetails.handlerType )
					{
						injector.apply( notification, [ handler ] );
					}
				}	
			}
						
			for each ( var callbackPair:CallbackTypePair in _callbackPairs )
			{
				if( notification is callbackPair.type )
				{
					callbackPair.callback.apply( null, [ notification ] );
				}
			}
		}
		
		internal function get handlers():Array
		{
			return _handlers;
		}
		
		internal function get callbackPairs():Array
		{
			return _callbackPairs;
		}
	}
}

import flash.utils.describeType;
import flash.utils.getDefinitionByName;

class NotificationDetails
{
	public var methodName:String;
	public var handlerType:Class;
	
	public function NotificationDetails( notification:Object )
	{
		var reflection:XML = describeType( notification );
		var node:XMLList = reflection..metadata.(@name == "InjectHandler");
		
		if( node
			&& node.parent() )
		{
			methodName = node.parent().@name;
			handlerType = getDefinitionByName( node.parent().parameter.@type ) as Class;
		}
	}
}

class CallbackTypePair
{
	public var callback:Function;
	public var type:Class;
	
	public function CallbackTypePair( callback:Function, type:Class )
	{
		this.callback = callback;
		this.type = type;
	}
}


