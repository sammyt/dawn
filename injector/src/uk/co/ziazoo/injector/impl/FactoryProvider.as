package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IProvider;
  
  public class FactoryProvider implements IProvider
  {
    private var factoryType:Class;
    private var params:Array;
    private var factory:Object;
    private var reflector:Reflector;
    private var methodName:String;
    
    public function FactoryProvider( factoryType:Class, reflector:Reflector )
    {
      this.reflector = reflector;
      this.factoryType = factoryType;
    }
    
    public function get type():Class
    {
      return factoryType;
    }
    
    public function getObject():Object
    {
      if( !factory )
      {
        factory = InstanceCreator.create( factoryType, params );
      }
      return invokeFactoryMethod();
    }
    
    public function withDependencies( dependencies:Array ):void
    {
      params = [];
      for each( var dependency:IDependency in dependencies )
      {
        params.push( dependency.getObject() );
      }
    }
    
    internal function invokeFactoryMethod():Object
    {
      var provider:Function = factory[ getMethodName() ] as Function;
      return provider.apply( factory );
    }
    
    private function getMethodName():String
    {
      if( !methodName )
      {
        var reflection:Reflection = reflector.getReflection( factoryType );
        
        if( reflection.hasProviderMethod() )
        {
          methodName = reflection.providerMethod.name;
        }
      }
      return methodName;
    }
  }
}