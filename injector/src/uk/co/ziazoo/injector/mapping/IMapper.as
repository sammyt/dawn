package uk.co.ziazoo.injector.mapping
{

	/**
	 * manages the mappings between classes and their providers.  An instance
	 * of this interface will be passed into the configuration so the user
	 * can create the custom mappings for their application
	 */ 
	public interface IMapper
	{
		/**
		 * Call this function to map a class to a providing class within
		 * the configuration. e.g.
		 * 
		 * <pre>
		 *  map(SuperClass).toClass(SubClass);
		 *  map(IInterface).toClass(Implementation);
		 *  map(IInterface).toClass(FastImplementation).withName("fast");
		 *  map(IDoThings).toInstance( new DoThings() );
		 * </pre>
		 */ 
		function map( clazz:Class ):IMap;
		
		/**
		 * @private
		 * 
		 * returns the <code>IMap</code> instance for a given
		 * class and name where supplied
		 */ 
		function getMap( clazz:Class, name:String = null ):IMap;
		
		/**
		 * @private
		 * 
		 * Where a class object is not present this function returns
		 * a <code>IMap</code> object for a given fully qualified class name.
		 */
		function getMapByName( className:String, name:String = null ):IMap;
	}
}