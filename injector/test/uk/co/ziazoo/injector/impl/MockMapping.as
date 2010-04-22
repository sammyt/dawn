package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;

  public class MockMapping implements IMapping
  {
    private var _type:Class;
    private var _name:String;
    
    public function MockMapping(type:Class, name:String = "")
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
      return null;
    }

    public function set provider(value:IProvider):void
    {
    }

    public function get name():String
    {
      return _name;
    }

    public function set name(value:String):void
    {
      _name = name;
    }

    public function get isJustInTime():Boolean
    {
      return false;
    }

    public function set isJustInTime(value:Boolean):void
    {
    }
  }
}