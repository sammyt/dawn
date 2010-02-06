package uk.co.ziazoo.injector
{	
	/**
	*	Maps a <code>Class</code> to a <code>IProvider</code> with
	*	a optional name
	*/
	public interface IMapping
	{	
		function get type():Class;
		function get provider():IProvider;
		function set provider(value:IProvider):void;
		function get name():String;
		function set name(value:String):void;
	}
}