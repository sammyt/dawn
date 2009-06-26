package uk.co.ziazoo.injector
{
	public interface IProvider
	{
		function get clazz():Class;
		
		function get name():String;
		
		function asSingleton():IProvider;
		
		function withName( name:String ):IProvider;
	}
}