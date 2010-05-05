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
     *  @inheritDoc
     */
    public function listen(type:Class, callback:Function,
      polymorphic:Boolean = false):Function
    {
      var cb:Details = new Details(callback, type);

      if (!polymorphic)
      {
        addNonPolymorphicCallback(cb);
      }
      else
      {
        addPolymorphicCallback(cb);
      }

      return callback;
    }

    private function addPolymorphicCallback(callback:Details):void
    {
      callbackList.push(callback);
    }

    private function addNonPolymorphicCallback(callback:Details):void
    {
      // are there already any other callbacks registered
      if (!callbackMap[callback.type])
      {
        callbackMap[callback.type] = [];
      }
      var list:Array = callbackMap[callback.type] as Array;
      list.push(callback);
    }

    /**
     *  @inheritDoc
     */
    public function remove(type:Class, callback:Function):void
    {
      removeFromMap(type, callback);
      removeFromList(type, callback);
    }

    private function removeFromList(type:Class, callback:Function):void
    {
      var index:int = callbackList.length - 1;

      while (index > -1)
      {
        var details:Details = callbackList[index] as Details;

        if (details.encapsulates(type, callback))
        {
          removeFromArray(callbackList, index);
          break;
        }
        index --;
      }
    }

    private function removeFromMap(type:Class, callback:Function):void
    {
      var mappedList:Array = callbackMap[type] as Array;

      if (!mappedList)
      {
        return;
      }
      var index:int = mappedList.length - 1;

      while (index > -1)
      {
        var details:Details = mappedList[index] as Details;

        if (details.callback == callback)
        {
          removeFromArray(mappedList, index);
          break;
        }
        index --;
      }
    }

    private function removeFromArray(array:Array, index:int):void
    {
      array.splice(index, 1)
    }

    /**
     *  @inheritDoc
     */
    public function trigger(payload:Object):void
    {
      var mappedList:Array = callbackMap[getType(payload)] as Array;

      if (mappedList)
      {
        var index:int = mappedList.length - 1;

        while (index > -1)
        {
          var callback:Details = mappedList[index] as Details;
          callback.call(payload);
          index --;
        }
      }
      invokePolymorphicCallbacks(payload);
    }

    private function invokePolymorphicCallbacks(notification:Object):void
    {
      var index:int = callbackList.length - 1;

      while (index > -1)
      {
        var callback:Details = callbackList[index] as Details;
        if (callback.isTriggeredBy(notification))
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