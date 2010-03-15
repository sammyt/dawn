package uk.co.ziazoo.injector
{	
  public interface IMappingBuilder
  {
    function to( clazz:Class ):IMappingBuilder;
    function toFactory( factory:Class ):IMappingBuilder;
    function toInstance( object:Object ):IMappingBuilder;
    function named( name:String ):IMappingBuilder;
    function asSingleton():void;
    function get mapping():IMapping;
  }
}