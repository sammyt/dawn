package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IMapping;

  public class EagerQueue implements IEagerQueue
  {
    private var items:Array;

    public function EagerQueue()
    {
      items = [];
    }

    /**
     * @inheritDoc
     */
    public function push(mapping:IMapping):void
    {
      items.push(mapping);
    }

    /**
     * @inheritDoc
     */
    public function pop():IMapping
    {
      return IMapping(items.pop());
    }

    public function get length():uint
    {
      return items.length;
    }
  }
}