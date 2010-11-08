/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/11/2010
 * Time: 21:25
 * To change this template use File | Settings | File Templates.
 */
package some.otherthing
{
  public class SlowBikeEngineWithPostConstruct extends SlowBikeEngine
  {
    public var subInvokeCount:int = 0;

    public function SlowBikeEngineWithPostConstruct()
    {
    }


    [PostConstruct]
    public function createdSubClass():void
    {
      subInvokeCount ++;
    }
  }
}
