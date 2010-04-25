package com.wheels.com.wheels.cars
{
  import com.wheels.Car;
  import com.wheels.Engine;
  import com.wheels.IDriveLine;
  import com.wheels.ManualTransmission;
  import com.wheels.PetrolEngine;
  import com.wheels.RearWheelDrive;
  import com.wheels.Transmission;

  import uk.co.ziazoo.injector.IPrivateConfiguration;
  import uk.co.ziazoo.injector.IPrivateMapper;

  public class SportyNumber implements IPrivateConfiguration
  {
    public function configure(mapper:IPrivateMapper):void
    {
      mapper.map(IDriveLine).to(RearWheelDrive);
      mapper.map(Transmission).to(ManualTransmission);
      mapper.map(Engine).to(PetrolEngine);

      // expose this configuration under two mappings
      mapper.expose(Car, "sports car");
      mapper.expose(Car, "sporty");
    }
  }
}