package some.thing
{
  public class PlantPotFactory
  {

    [Inject]
    public var engine:Engine;

    public function PlantPotFactory()
    {
    }

    [Provider]
    public function getPlantPot():PlantPot
    {
      return new PlantPot();
    }
  }
}