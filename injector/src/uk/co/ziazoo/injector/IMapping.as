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
     */ 
    function get type():Class;
    
    /**
     * The instance of IProvider that creates the instance
     */ 
    function get provider():IProvider;
    function set provider(value:IProvider):void;
    
    /**
     * an optional name for the mapping
     */ 
    function get name():String;
    function set name(value:String):void;
    
    function get isEager():Boolean;
    function set isEager(value:Boolean):void;
    
  }
}