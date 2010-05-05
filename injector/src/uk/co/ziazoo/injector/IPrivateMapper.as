package uk.co.ziazoo.injector
{
  public interface IPrivateMapper extends IMapper
  {
    /**
     * Exposing a named type allows the injector to use
     * the mappings found in a private configuration when that type and
     * name is requested from the injector
     *
     * @param type Class to expose
     * @param name to expose with
     */
    function expose(type:Class, name:String):void;
  }
}