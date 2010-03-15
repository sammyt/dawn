package uk.co.ziazoo.command
{
  public class MockCommand 
  {
    public var invokeCount:int = 0;
    
    public function MockCommand(){}
    
    [Execute]
    public function doIt( note:String ):void
    {
      invokeCount ++;
    }
  }
}