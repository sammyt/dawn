package uk.co.ziazoo.injector 
{
  import uk.co.ziazoo.injector.impl.Reflector;
  
  public interface IDependency
  {
    function getMapping():IMapping;
    
    function getProvider():IProvider;
    
    function getParent():IInjectionPoint;
    
    function getObject():Object;
    
    function get parameterIndex():int;
    function set parameterIndex(value:int):void;
  }
}

