package some.thing
{
  public class PlantPotFactory
  {
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