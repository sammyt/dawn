package some.otherthing
{
  public class ThingWithThreeEngines extends ThingWithTwoEngines
  {
    [Inject]
    public var engine3:ReallySlowBikeEngine;

    public function ThingWithThreeEngines()
    {
      super();
    }
  }
}