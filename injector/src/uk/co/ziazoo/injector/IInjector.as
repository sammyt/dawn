package uk.co.ziazoo.injector
{
  import flash.system.ApplicationDomain;

  /**
   * The core interface to Dawns injection capabilities
   */
  public interface IInjector
  {
    /**
     * Injects the object of class provided
     *
     * e.g.
     * inject(IService), inject(myServiceObj) or inject(IThing, "foo")
     *
     * @param object can be a class of and instance
     * @param name an optional name where a specific mapping is required
     * @return the injected object
     */
    function inject(object:Object, name:String = ""):Object;

    /**
     * Dawn knows how to provide dependencies for injection
     * because of the configuration provided with used create IConfiguration
     * objects
     *
     * @param configuration to install into this injector
     */
    function install(configuration:IConfiguration):void;

    /**
     * Sometimes it can be useful to define multiple different object graphs
     * without creating new concrete classes that define those graphs.  private
     * configurations enable this though installing private mappings that
     * will only be used when special exposed mappings are requested
     *
     * @param configuration the private configuration to install
     * @return private configurations create child injectors under the hood, you
     * do not need to keep a reference to them if you do not want to as the
     * mappings will be accessible to this (parent) injector through the
     */
    function installPrivate(configuration:IPrivateConfiguration):IInjector;

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
     * Tries to get a IMapping for the name and type provided. Where
     * none exists the parent injector is tried until it is just-in-time mapped
     *
     * @param type of object who's mapping you want
     * @param name optional name of mapping you want (blank by default)
     * @return IMapping where one is found, else null
     */
    function getMapping(type:Class, name:String = ""):IMapping;

    /**
     * Tests is this IMapper has a mapping for the type and name supplied
     *
     * @param type of object who's mapping you are searching for
     * @param name optional name of the mapping
     * @return true if a mapping exists in this IMapper, else false
     */
    function hasMapping(type:Class, name:String = ""):Boolean;

    /**
     * Remove with the type and name the mapping is created for
     *
     * @param type of mapping to remove
     * @param name of mapping to remove
     */
    function removeMapping(type:Class, name:String = ""):void;

    /**
     * Creates a child injector of this instance.  A child injector inherits
     * all the mappings of this injector, and can define its own that
     * are not shared back up the tree
     *
     * @return the new child IInjector
     */
    function createChildInjector(applicationDomain:ApplicationDomain = null):IInjector;

    /**
     * Some mappings are created automatically by Dawn when no user mapping
     * is provided, these mappings are called just-in-time mappings and
     * are created here
     *
     * @param type the type to map
     * @param name for mapping
     * @return IMappingBuilder tp construct mapping
     */
    function justInTimeMap(type:Class, name:String):IMapping;

    /**
     * If this child was created as a child of another injector this
     * points to the parent
     * @return parent injector this one was created from, else null
     */
    function get parent():IInjector;

    /**
     * The <code>IMapper</code> instance for this injector
     * @return injectors mapper instance
     */
    function get mapper():IMapper;

    function get applicationDomain():ApplicationDomain;
    
    function tearDown():void;
  }
}