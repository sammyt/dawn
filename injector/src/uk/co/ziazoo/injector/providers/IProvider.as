package uk.co.ziazoo.injector.providers
{
	public interface IProvider
	{
		function get clazz():Class;
		
		function get name():String;
		
		function get singleton():Boolean;
		
		function asSingleton():IProvider;
		
		function withName( name:String ):IProvider;
		
		function addAccessor( name:String, provider:IProvider ):void;
		
		function getAccessor( provider:IProvider ):String;
		
		function createInstance():Object;
	}
}