package some.thing
{
  public class LittleEngine extends Engine
  {
    [Inject(name="cylinder count")]
    public var cylinders:int = 0;

    public function LittleEngine()
    {
      super();
    }
  }
}