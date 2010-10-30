package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;

  import uk.co.ziazoo.injector.IMappingBuilderFactory;
  import uk.co.ziazoo.injector.IPrivateMapper;

  public class PrivateMapper extends Mapper implements IPrivateMapper
  {
    private var parent:IMapperList;

    /**
     * Creates a PrivateMapper used when installing private configuration
     * into a injector
     *
     * @param builderFactory used to create mappings
     */
    public function PrivateMapper(builderFactory:IMappingBuilderFactory, parent:IMapperList, applicationDomain:ApplicationDomain)
    {
      super(builderFactory, applicationDomain);

      this.parent = parent;
    }

    public function expose(type:Class, name:String):void
    {
      parent.expose(type, name, this);
    }
  }
}