package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.injector.IMapper;

  /**
   * A list of mappers is necessary so private configurations can be accessed
   * when a given key is requested
   */
  public interface IMapperList extends IMapper
  {
    /**
     * Allows a child injector to expose its mappings through a type and name
     * @param type used to expose with
     * @param name used to expose with
     * @param mapper containing mappings to expose
     */
    function expose(type:Class, name:String, mapper:IMapper):void;

    /**
     * Private configurations are only used when there exposed keys are
     * requested in the process of creating an object graph.  Once that object
     * graph has been created they are hidden again by calling this method
     */
    function injectionComplete():void;
  }
}