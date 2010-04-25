package com.wheels.com.wheels.cars
{
  import com.wheels.AutomaticTransmission;
  import com.wheels.Car;
  import com.wheels.DieselEngine;
  import com.wheels.Engine;
  import com.wheels.FourWheelDrive;
  import com.wheels.IDriveLine;
  import com.wheels.Transmission;

  import uk.co.ziazoo.injector.IPrivateConfiguration;
  import uk.co.ziazoo.injector.IPrivateMapper;

  public class ChelseaTractor implements IPrivateConfiguration
  {
    public function configure(mapper:IPrivateMapper):void
    {
      mapper.map(Engine).to(DieselEngine);
      mapper.map(Transmission).to(AutomaticTransmission);
      mapper.map(IDriveLine).to(FourWheelDrive);

      mapper.expose(Car, "chelsea tractor");
    }
  }
}