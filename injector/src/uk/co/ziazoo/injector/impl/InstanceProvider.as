package uk.co.ziazoo.injector.impl
{
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;
  
  import uk.co.ziazoo.injector.IProvider;
  
  internal class InstanceProvider implements IProvider
  {
    private var instance:Object;
    private var _type:Class;
    
    public function InstanceProvider( instance:Object )
    {
      this.instance = instance;
    }
    
    public function get type():Class
    {
      if( !_type )
      {
        _type = Class( getDefinitionByName( getQualifiedClassName( instance ) ) );
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
      return false;
    }
    
    public function withDependencies( dependencies:Array ):void
    {
    }
  }
}