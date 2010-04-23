package uk.co.ziazoo.injector
{
  public interface IMappingBuilderFactory
  {
    /**
     * Create a IMappingBuilder for the type provided
     *
     * @param type the class you want to map
     * @return a mapping builder you can use to build your mapping
     */
    function forType(type:Class):IMappingBuilder;
  }
}