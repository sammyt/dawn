package uk.co.ziazoo.injector
{
  /**
   * The core interface to Dawns injection capabilities
   */
  public interface IInjector
  {
    /**
     * Injects the object of class provided
     *
     * e.g.
     * inject(IService) or inject(myServiceObj)
     *
     * @param object can be a class of and instance
     * @return the injected onject
     */
    function inject(object:Object):Object;

    /**
     * Dawn knows how to provide dependencies for injection
     * because of the configuration provided with used create IConfiguration
     * objects
     *
     * @param configuration to install into this injector
     */
    function install(configuration:IConfiguration):void;

    /**
     * Short had version of using IConfiguration instances.  Use this method
     * to install mappings into the injector one at a time.  Favour
     * configurations over this in production
     *
     * @param type the type you want to map
     * @return a IMappingBuilder to create the mapping with
     */
    function map(type:Class):IMappingBuilder;

    /**
     * Creates a child injector of this instance.  A child injector inherits
     * all the mappings of this injector, and can define its own that
     * are not shared back up the tree
     *
     * @return the new child IInjector
     */
    function createChildInjector():IInjector;
  }
}