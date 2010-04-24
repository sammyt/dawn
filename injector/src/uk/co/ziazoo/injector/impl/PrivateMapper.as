package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IMappingBuilderFactory;
  import uk.co.ziazoo.injector.IPrivateMapper;

  public class PrivateMapper extends Mapper implements IPrivateMapper
  {
    /**
     * Creates a PrivateMapper used when installing private configuration
     * into a injector
     *
     * @param builderFactory used to create mappings
     */
    public function PrivateMapper(builderFactory:IMappingBuilderFactory)
    {
      super(builderFactory);
    }

    public function expose(type:Class, name:String):void
    {

    }
  }
}