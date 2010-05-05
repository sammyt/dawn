package some.thing
{
  public class AppleFactory
  {
    public var engine:Engine;

    public function AppleFactory(engine:Engine)
    {
      this.engine = engine;
    }

    [Provider]
    public function getMyApple():Apple
    {
      return new Apple();
    }
  }
}