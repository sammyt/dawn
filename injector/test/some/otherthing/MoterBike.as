package some.otherthing
{
  public class MoterBike
  {
    public var dial:IDial;
    public var engine:IBikeEngine;
    
    public function MoterBike(engine:IBikeEngine)
    {
      this.engine = engine; 
    }
    
    [Inject]
    public function setSpeedDial(dial:IDial):void{
      this.dial = dial;
    }
  }
}