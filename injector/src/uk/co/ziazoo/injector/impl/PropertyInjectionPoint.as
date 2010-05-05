package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.model.Property;
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IInjectionPoint;

  internal class PropertyInjectionPoint implements IInjectionPoint
  {
    private var dependencies:Array;
    private var _property:Property;

    public function PropertyInjectionPoint(property:Property)
    {
      _property = property;
    }

    public function get property():Property
    {
      return _property;
    }

    public function getDependencies():Array
    {
      return dependencies;
    }

    public function isOptional():Boolean
    {
      return false;
    }

    public function setDependency(dependency:IDependency):void
    {
      dependencies = [ dependency ];
    }
  }
}