package uk.co.ziazoo.injector
{
  import flash.system.ApplicationDomain;

  public interface IMapper
  {
    /**
     * Start the DSL for mapping a type to its provider
     *
     * @param type the Class whos mapping is being created
     * @return IMappingBuilder with relevant DSL methods
     */
    function map(type:Class):IMappingBuilder;

    /**
     * Tries to get a IMapping for the name and type provided. Where
     * none exists null is returned
     *
     * @param type of object who's mapping you want
     * @param name optional name of mapping you want (blank by default)
     * @return IMapping where one is found, else null
     */
    function getMapping(type:Class, name:String = ""):IMapping;

    /**
     * When you don't have the Class for the type only the qualified name
     * (e.g. when reflecting).
     *
     * @param qName qualified name of the type com.example::Bacon
     * @param name optional name of mapping you want (blank by default)
     * @return IMapping where one is found, else null
     */
    function getMappingForQName(qName:String, name:String = ""):IMapping;

    /**
     * Tests is this IMapper has a mapping for the type and name supplied
     *
     * @param type of object who's mapping you are searching for
     * @param name optional name of the mapping
     * @return true if a mapping exists in this IMapper, else false
     */
    function hasMapping(type:Class, name:String = ""):Boolean;

    /**
     * Add a mapping to this IMapper
     * @param mapping you want to add
     */
    function add(mapping:IMapping):void;

    /**
     * Removes a mapping by reference
     * @param mapping the mapping you want to remove
     */
    function remove(mapping:IMapping):void;

    /**
     * When you dont have the mapping reference you can remove with the
     * type and name the mapping is created against
     *
     * @param type of mapping to remove
     * @param name of mapping to remove
     */
    function removeFor(type:Class, name:String = ""):void;

    /**
     * Some mappings are created automatically by Dawn when no user mapping
     * is provided, these mappings are called just-in-time mappings and
     * are created here
     *
     * @param type the type to map
     * @param name for mapping
     * @return IMappingBuilder tp construct mapping
     */
    function justInTimeMap(type:Class, name:String = ""):IMappingBuilder;

    /**
     * For creating just-in-time mappings using the qualified name
     *
     * @param qName qualified name of type
     * @param name of mapping, blank by default
     * @return IMappingBuilder for mapping
     */
    function justInTimeMapByQName(qName:String, name:String = ""):IMappingBuilder;

    function get applicationDomain():ApplicationDomain;
  }
}