package uk.co.ziazoo.injector
{
  /**
   *  Maps a <code>Class</code> to a <code>IProvider</code> with
   *  a optional name
   */
  public interface IMapping
  {
    /**
     * The class being mapped
     *
     * @return Class of this type
     */
    function get type():Class;

    /**
     * The instance of IProvider that creates the instance
     *
     * @return the <code>IProvider</code> for this mapping
     */
    function get provider():IProvider;

    function set provider(value:IProvider):void;

    /**
     * an optional name for the mapping
     *
     * @return the name of the mapping
     * @default ""
     */
    function get name():String;

    function set name(value:String):void;

    /**
     * was this mapping created just-in-time
     *
     * @return true if mapping as not provided by user
     */
    function get isJustInTime():Boolean;

    function set isJustInTime(value:Boolean):void;
  }
}