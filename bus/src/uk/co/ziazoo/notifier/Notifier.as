package uk.co.ziazoo.notifier
{ 
  import flash.utils.Dictionary;
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;

  public class Notifier implements INotifier
  {	
    /**
     * @private
     * 
     * listener type to callback list map 
     */
    internal var callbackMap:Dictionary;
    
    /**
     * @private
     * 
     * stores the callbacks who require polymorphic inspection
     */ 
    internal var callbackList:Array;
    
    public function Notifier()
    {
      callbackMap = new Dictionary();
      callbackList = [];
    }
    
    /**
     *	@inheritDoc
     */		
    public function add(notificationType:Class, 
      callback:Function, polymorphic:Boolean=false):Function
    {
      var cb:Callback = new Callback(callback, notificationType);
      
      if(!polymorphic)
      {
        addNonPolymorphicCallback(cb);
      }
      else
      {
        addPolymorphicCallback(cb);
      }
      
      return callback;
    }
    
    private function addPolymorphicCallback(callback:Callback):void
    {
      callbackList.push(callback);
    }
    
    private function addNonPolymorphicCallback(callback:Callback):void
    {
      // are there already any other callbacks registered
      if(!callbackMap[callback.type])
      {
        callbackMap[callback.type] = [];
      }
      var list:Array = callbackMap[callback.type] as Array;
      list.push(callback);
    }
    
    /**
     *	@inheritDoc
     */		
    public function remove(callback:Function):void
    {
      /*
      var index:int = 0;
      for each(var current:Callback in _callbacks)
      {
        if(current.encapsulates(callback, notificationType))
        {
          _callbacks.splice(index, 1);
          return;
        }
        index++;
      }
      */
    }
    
    /**
     *	@inheritDoc
     */	
    public function trigger(notification:Object):void
    { 
      
      var mappedList:Array = callbackMap[getType(notification)] as Array;
      var index:uint = mappedList.length;
      
      while(index > -1)
      {
        var callback:Callback = mappedList[index] as Callback;
        callback.call(notification);
        index --;
      }
      invokePolymorphicCallbacks(notification);
    }
    
    private function invokePolymorphicCallbacks(notification:Object):void
    {  
      var index:uint = callbackList.length;
      
      while(index > -1)
      {
        var callback:Callback = callbackList[index] as Callback;
        if(callback.isTriggeredBy(notification))
        {
          callback.call(notification);
        }
        index --;
      }
    }
    
    private function getType(object:Object):Class
    {
      return getDefinitionByName(getQualifiedClassName(object)) as Class;
    }
  }
}