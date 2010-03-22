package uk.co.ziazoo.injector
{	
  public interface IMapper
  {
    function map( clazz:Class ):IMappingBuilder;
    
    function getMapping( type:Class, name:String = "" ):IMapping;
    
    function getMappingFromQName( qName:String, name:String = "" ):IMapping;
    
    function addToEagerQueue(mapper:IMapping):void;
    
    function getEagerQueue():Array;
  }
}