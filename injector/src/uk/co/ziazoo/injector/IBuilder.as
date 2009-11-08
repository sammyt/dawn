package uk.co.ziazoo.injector
{
	/**
	 * the builder provides a simple factory like interface
	 * which you can use to ask Dawn to build any mapped class
	 */ 
	public interface IBuilder
	{
		/**
		*	returns an instance of the class supplied as
		*	an arguement.  Any dependencies the entryPoint class
		*	has will also be created and injected into the return instance
		*	  
		*	@param	entryPoint	 The object that you want to construct and inject.
		*	@return		The constructed object of type entryPoint
		*/
		function getObject( entryPoint:Class ):Object;
		
		/**
		*	application configuration can be devided over a number
		*	of configurations and added via this method
		*	
		*	@param	config:IConfig	 A configuration object which will map
		*	some or all of the applications classes
		*/	
		function addConfig( config:IConfig ):void;
	}
}