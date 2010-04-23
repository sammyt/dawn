package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IMappingBuilderFactory;

  public class MappingBuilderFactory implements IMappingBuilderFactory
  {
    /**
     * provides reflection information for the builder
     */
    private var reflector:Reflector;

    /**
     * allows mappings to be added to eager queue once mapped
     */
    private var eagerQueue:IEagerQueue;

    public function MappingBuilderFactory(
      reflector:Reflector, eagerQueue:IEagerQueue)
    {
      this.reflector = reflector;
      this.eagerQueue = eagerQueue;
    }

    /**
     * @inheritDoc
     */
    public function forType(type:Class):IMappingBuilder
    {
      return new MappingBuilder(type, reflector, eagerQueue);
    }
  }
}