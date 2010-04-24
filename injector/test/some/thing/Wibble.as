package some.thing
{
  [Named(index="1",name="granny")]
  public class Wibble
  {
    public var apple:Apple;

    [Inject(name="loud")]
    public var radio:IRadio;

    public function Wibble(apple:Apple)
    {
      this.apple = apple;
    }
  }
}