package uk.co.ziazoo.injector
{
  public interface IEagerQueue
  {
    /**
     * Adds a mapping to the queue, so that it can be
     * created in the next batch
     *
     * @param mapping for type to eagerly create
     */
    function push(mapping:IMapping):void;

    /**
     * Get the next mapping to create and remove it from the queue
     * @return mapping for type to eagerly create next
     */
    function pop():IMapping;

    /**
     * The number of mappings left in the queue
     * @return uint for the length of the queue
     */
    function get length():uint;
  }
}