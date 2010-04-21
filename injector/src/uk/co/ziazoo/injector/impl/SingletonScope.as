package uk.co.ziazoo.injector.impl 
{
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;

  internal class SingletonScope implements IScope
  {
    private var provider:IProvider;
    private var instance:Object;
    
    public function SingletonScope()
    {
    }
    
    public function wrap(provider:IProvider):IScope
    {
      this.provider = provider;
      return this;
    }
    
    public function get requiresInjection():Boolean
    {
      if( instance )
      {
        return false;
      }
      else
      {
        return provider.requiresInjection;
      }
    }
    
    public function get instanceCreated():Boolean
    {
      return provider.instanceCreated;
    }
    
    public function getObject():Object
    {
      if( !instance )
      {
        instance = provider.getObject();
      }
      return instance;
    }
  }
}

