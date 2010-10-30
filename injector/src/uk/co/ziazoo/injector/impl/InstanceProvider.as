package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;
  import flash.utils.getQualifiedClassName;

  import uk.co.ziazoo.injector.IProvider;

  internal class InstanceProvider implements IProvider
  {
    private var instance:Object;
    private var _type:Class;
    private var applicationDomain:ApplicationDomain;

    public function InstanceProvider(instance:Object, applicationDomain:ApplicationDomain)
    {
      this.instance = instance;
      this.applicationDomain = applicationDomain;
    }

    public function get type():Class
    {
      if (!_type) {
        _type = Class(applicationDomain.getDefinition(getQualifiedClassName(instance)));
      }
      return _type;
    }

    public function getObject():Object
    {
      return instance;
    }

    public function get requiresInjection():Boolean
    {
      return true;
    }

    public function get instanceCreated():Boolean
    {
      return true;
    }

    public function setDependencies(dependencies:Array):void
    {
    }
  }
}