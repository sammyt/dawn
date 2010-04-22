package uk.co.ziazoo.injector.impl 
{
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;

  internal class Mapping implements IMapping
  {
    private var _type:Class;
    private var _name:String;
    private var _provider:IProvider;
    private var _isJustInTime:Boolean;
    
    public function Mapping( type:Class, name:String = "", 
      provider:IProvider = null )
    {
      _type = type;
      _name = name;
      _provider = provider;
    }

    /**
     * @inheritDoc
     */
    public function get type():Class
    {
      return _type;
    }

    /**
     * @inheritDoc
     */
    public function get provider():IProvider
    {
      return _provider;
    }
    
    public function set provider(value:IProvider):void 
    {
      _provider = value;
    }
    

    /**
     * @inheritDoc
     */
    public function get name():String
    {
      return _name;
    }
    
    public function set name(value:String):void 
    {
      _name = value;
    }

    /**
     * @inheritDoc
     */
    public function get isJustInTime():Boolean
    {
      return _isJustInTime;
    }

    public function set isJustInTime(value:Boolean):void
    {
      _isJustInTime = value;
    }
  }
}

