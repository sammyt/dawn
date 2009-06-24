package uk.co.ziazoo.injector
{
	public interface IMap
	{
		
		function get isProviderFactory():Boolean;
		
		/**
		 * Where the map represents a named
		 * provider, this is that name
		 */ 
		function get name():String;
		
		/**
		 *	The class whose map of provider
		 *	this object represents
		 */	
		function get clazz():Class;
		
		/**
		 *	The class which will be constructed
		 */  
		function get provider():Class;
		
		/**
		 *	the output of getQualifiedClassName on the clazz
		 */	
		function get clazzName():String;
		
		/**
		 *	the output of getQualifiedClassName on the provider
		 */	
		function get providerName():String;
		
		/**
		 *	The scope of this class
		 */	
		function get singleton():Boolean;		
		function set singleton( value:Boolean ):void;

		/**
		 * Create an instance of the provider
		 */ 
		function provideInstance():Object;
		
		/**
		 * maps a class to an accessor name so the IOC code
		 * know how to set the dependency
		 */ 
		function addAccessor( name:String, clazzName:String ):void;
		
		/**
		 * returns an accessor name for a given class type
		 */ 
    	function getAccessor( clazzName:String ):String;
	}
}