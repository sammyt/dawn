package some.otherthing
{
  public class SlowBike extends MoterBike
  {

    [Inject(name="bike name")]
    public var name:String;

    public function SlowBike(engine:SlowBikeEngine)
    {
      super(engine);
      trace("got me a engine");
    }

    [Inject]
    [Named(index="1", name="analog")]
    override public function setSpeedDial(dial:IDial):void
    {
      super.setSpeedDial(dial);
    }

    public function doALittleDance():void
    {

    }
  }
}