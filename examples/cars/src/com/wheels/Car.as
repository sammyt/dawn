package com.wheels
{
  public class Car
  {
    private var transmission:Transmission;
    private var engine:Engine;
    private var driveLine:IDriveLine;

    public function Car(transmission:Transmission,
      engine:Engine, driveLine:IDriveLine)
    {
      this.transmission = transmission;
      this.engine = engine;
      this.driveLine = driveLine;
    }

    public function toString():String
    {
      return "Car " + transmission + " " + engine + " " + driveLine;
    }
  }
}