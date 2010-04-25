package
{
  import com.wheels.Car;
  import com.wheels.FrontWheelDrive;
  import com.wheels.IDriveLine;
  import com.wheels.com.wheels.cars.ChelseaTractor;
  import com.wheels.com.wheels.cars.SportyNumber;

  import flash.display.Sprite;

  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.injector.impl.Injector;

  public class ShowRoom extends Sprite
  {
    public function ShowRoom()
    {
      // create injector
      var injector:IInjector = Injector.createInjector();
      injector.map(IDriveLine).to(FrontWheelDrive);

      // install car configurations
      injector.installPrivate(new ChelseaTractor());
      injector.installPrivate(new SportyNumber());

      // create some cars
      var chelseaTractor:Car = Car(injector.inject(Car, "chelsea tractor"));
      var sporty:Car = Car(injector.inject(Car, "sporty"));
      var alsoSporty:Car = Car(injector.inject(Car, "sports car"));
      var basicCar:Car = Car(injector.inject(Car));

      trace(chelseaTractor);
      trace(sporty);
      trace(alsoSporty);
      trace(basicCar);
    }
  }
}