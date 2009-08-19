package uk.co.ziazoo.injector.providers
{
	public interface IProvider
	{
		/**
		 * the class the provider generates
		 */ 
		function get clazz():Class;
		
		/**
		 * if this is a named privider this property
		 * returns the name
		 */ 
		function get name():String;
		
		/**
		 * true if this is a singleton provider
		 */ 
		function get singleton():Boolean;
		
		/**
		 * makes this a singleton provider so only one
		 * instance of clazz will be created by this provider
		 */ 
		function asSingleton():IProvider;
		
		/**
		 * makes this a named provider with the 
		 * name supplied
		 */ 
		function withName( name:String ):IProvider;
		
		/**
		 * sets the accessor name for a given provider
		 */ 
		function addAccessor( name:String, provider:IProvider ):void;
		
		/**
		 * get the accessor name for a given provider
		 */ 
		function getAccessor( provider:IProvider ):String;
		
		/**
		 * Get the instance this provider creates.  If this
		 * is a singleton provider the instance will be the
		 * same every time
		 */ 
		function getInstance():Object;
		
		/**
		 * if this is a factory provider this will return
		 * the instance the factory produces
		 */ 
		function invokeGenerator():Object;
		
		/**
		 * The name of the function marked as a completion trigger
		 */ 
		function set completionTrigger( name:String ):void;
		function get completionTrigger():String;
		
		function get hasCompletionTrigger():Boolean;
		
		function onDependenciesInjected():void;
		
		function get hasDependencies():Boolean;
	}
}