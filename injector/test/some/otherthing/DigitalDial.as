package some.otherthing
{
  public class DigitalDial implements IDial
  {
    public var invokeCount:int = 0;
    
    public function DigitalDial()
    {
    }
    
    [DependenciesInjected]
    public function created():void
    {
      invokeCount++;
    }
  }
}