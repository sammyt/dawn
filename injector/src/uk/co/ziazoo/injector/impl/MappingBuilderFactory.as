package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;

  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IMappingBuilderFactory;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  public class MappingBuilderFactory implements IMappingBuilderFactory
  {
    /**
     * allows mappings to be added to eager queue once mapped
     */
    private var eagerQueue:IEagerQueue;
    private var detailsFactory:ITypeInjectionDetailsFactory;
    private var applicationDomain:ApplicationDomain;

    public function MappingBuilderFactory(eagerQueue:IEagerQueue, detailsFactory:ITypeInjectionDetailsFactory, applicationDomain:ApplicationDomain)
    {
      this.eagerQueue = eagerQueue;
      this.detailsFactory = detailsFactory;
      this.applicationDomain = applicationDomain;
    }

    /**
     * @inheritDoc
     */
    public function forType(type:Class):IMappingBuilder
    {
      return new MappingBuilder(type, eagerQueue, detailsFactory, applicationDomain);
    }
  }
}