package uk.co.ziazoo.injector
{
	/**
	*	The <code>IMapper</code> interface provides methods
	*	to map classes or intrefaces to their providers.  Providers
	*	are the implementations which you want instantiated when
	*	a given class is described as a dependency via the [Inject]
	*	metadata.
	*/	
	public interface IMapper
	{
		/**
		*	maps a class or interface to an implementation
		*/	
		function map( clazz:Class, provider:Class = null, name:String = null ):IMap;
		
		/**
		*	maps a class or interface to a function the user provides 
		*	which will instantiate the implementation
		*/	
		function mapToFactory( clazz:Class, provider:Function, name:String = null ):IMap;
	}
}