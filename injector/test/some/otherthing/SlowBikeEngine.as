package some.otherthing
{
  public class SlowBikeEngine implements IBikeEngine
  {
    public var invokeCount:int = 0;

    public function SlowBikeEngine()
    {
    }

    [PostConstruct]
    public function created():void
    {
      invokeCount++;
    }
  }
}