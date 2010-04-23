package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;

  public class MockMapping implements IMapping
  {
    private var _type:Class;
    private var _name:String;
    private var _provider:IProvider;
    private var _justInTime:Boolean;

    public function MockMapping(type:Class = null, name:String = "")
    {
      _type = type;
      _name = name;
    }

    public function get type():Class
    {
      return _type;
    }

    public function get provider():IProvider
    {
      return _provider;
    }

    public function set provider(value:IProvider):void
    {
      _provider = value;
    }

    public function get name():String
    {
      return _name;
    }

    public function set name(value:String):void
    {
      _name = value;
    }

    public function get isJustInTime():Boolean
    {
      return _justInTime;
    }

    public function set isJustInTime(value:Boolean):void
    {
      _justInTime = value;
    }
  }
}