package uk.co.ziazoo.injector.impl
{
  internal class InstancePropertyInjector implements IInstanceInjector
  {
    private var childInstance:Object;
    private var propertyName:String;

    public function InstancePropertyInjector(
      propertyName:String, childInstance:Object)
    {
      this.propertyName = propertyName;
      this.childInstance = childInstance;
    }

    public function inject(instance:Object):void
    {
      instance[ propertyName ] = childInstance;
    }
  }
}

