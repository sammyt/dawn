/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 26/11/2010
 * Time: 19:48
 * To change this template use File | Settings | File Templates.
 */
package some.more
{
  import some.thing.Car;
  import some.thing.Engine;
  import some.thing.IRadio;

  public class OptionalCArgs
  {
    public var car:Car;
    public var radio:IRadio;
    public var engine:Engine;

    public function OptionalCArgs(car:Car = null, engine:Engine = null,
            radio:IRadio = null)
    {
      this.car = car;
      this.radio = radio;
      this.engine = engine;
    }
  }
}
