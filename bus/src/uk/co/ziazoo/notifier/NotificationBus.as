package uk.co.ziazoo.notifier
{
  import flash.utils.Dictionary;
  import flash.utils.getQualifiedClassName;
  
  public class NotificationBus implements INotificationBus
  {	
    protected var _handlers:Array;
    protected var _callbacks:Array;
    protected var _notificationDetailsMap:Dictionary;
    
    public function NotificationBus()
    {
    }
    
    /**
     *	@inheritDoc
     */		
    public function addHandler( handler:Object ):IListenerRegistration
    {
      if( !_handlers )
      {
        _handlers = new Array();
      }
      _handlers.push( handler );
      
      return new HandlerListenerRegistration( this, handler );
    }
    
    /**
     *	@inheritDoc
     */		
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
    
    /**
     *	@inheritDoc
     */		
    public function addCallback( notificationType:Class, callback:Function ):IListenerRegistration
    {
      if( !_callbacks )
      {
        _callbacks = new Array();
      }
      
      var cb:Callback = new Callback( callback, notificationType );
      _callbacks.push( cb );
      
      return new CallbackListenerRegistration( this, cb );
    }
    
    /**
     *	@inheritDoc
     */		
    public function removeCallback( notificationType:Class, callback:Function ):void
    {
      var index:int = 0;
      for each( var current:Callback in _callbacks )
      {
        if( current.encapsulates( callback, notificationType ) )
        {
          _callbacks.splice( index, 1 );
          return;
        }
        index++;
      }
    }
    
    /**
     *	@inheritDoc
     */	
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
      
      for each ( var callback:Callback in _callbacks )
      {
        if( callback.isTriggeredBy( notification ) )
        {
          callback.call( notification );
        }
      }
    }
    
    internal function get handlers():Array
    {
      return _handlers;
    }
    
    internal function get callbacks():Array
    {
      return _callbacks;
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
