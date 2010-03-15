package some.thing 
{
  public class Car
  {
    private var _engine:Engine;
    
    public function Car()
    {
    }
    
    [Inject]
    public function set engine(value:Engine):void 
    {
      _engine = value;
    }
    
    public function get engine():Engine
    {
      return _engine;
    }
  }
}

