package uk.co.ziazoo.injector
{
  public interface IEagerQueue
  {
    function push(mapping:IMapping):void;

    function pop():IMapping;

    function get length():uint;
  }
}