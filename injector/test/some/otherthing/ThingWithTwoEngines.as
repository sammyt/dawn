package some.otherthing
{
  public class ThingWithTwoEngines
  {
    [Inject] public var engine1:IBikeEngine;
    [Inject] public var engine2:SlowBikeEngine;
    
    public function ThingWithTwoEngines()
    {
    }
  }
}