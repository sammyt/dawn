package some.thing
{
  public class EagerBunny
  {
    public static var createCount:int = 0;

    public function EagerBunny()
    {
      createCount++;
    }

  }
}