package uk.co.ziazoo.notifier
{
  internal class Details
  {
    internal var callback:Function;
    internal var type:Class;

    public function Details(callback:Function, type:Class)
    {
      this.callback = callback;
      this.type = type;
    }

    public function isTriggeredBy(notification:Object):Boolean
    {
      return notification is type;
    }

    public function call(notification:Object):void
    {
      callback.apply(null, [ notification ]);
    }

    public function encapsulates(type:Class, callback:Function):Boolean
    {
      return callback == this.callback && type == this.type;
    }
  }
}

