package uk.co.ziazoo.injector
{
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

