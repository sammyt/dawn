package uk.co.ziazoo.injector
{
	/**
	 * the builder provides a simple factory like interface
	 * which you can use to ask Dawn to build any mapped class
	 */ 
	public interface IBuilder
	{
		/**
		 * returns an instance of the class supplied as
		 * an arguement.  Any dependencies the entryPoint class
		 * has will also be created and injected into the return instance
		 */
		function getObject( entryPoint:Class ):Object;
	}
}