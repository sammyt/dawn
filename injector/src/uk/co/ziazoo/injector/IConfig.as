package uk.co.ziazoo.injector
{
	/**
	 * defines the interface a Dawn configuration class must implement. 
	 */
	public interface IConfig
	{
		/**
		 * This method will contain calls to the <code>map</code> 
		 * function of the <code>IMapper</code> supplied.  It is here 
		 * that you create the mappings for the classes within your application e.g.
		 * 
		 * <pre>
		 * 	mapper.map(IDoSomething).toClass(ThingThatDoesStuff);
		 * </pre>
		 */ 
		function create( mapper:IMapper ):void;
	}
}