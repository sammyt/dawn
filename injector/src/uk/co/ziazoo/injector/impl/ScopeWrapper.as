package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;
  
  public class ScopeWrapper implements IProvider
  {
    private var scope:IScope;
    private var provider:IProvider;
    
    public function ScopeWrapper(scope:IScope, provider:IProvider)
    {
      this.scope = scope;
      this.provider = provider;
    }
    
    public function get type():Class
    {
      return provider.type;
    }
    
    public function withDependencies(dependencies:Array):void
    {
      provider.withDependencies(dependencies);
    }
    
    public function get requiresInjection():Boolean
    {
      return scope.requiresInjection;
    }
    
    public function get instanceCreated():Boolean
    {
      return scope.instanceCreated;
    }
    
    public function getObject():Object
    {
      return scope.getObject();
    }
  }
}