package uk.co.ziazoo.injector.mapping
{
	import uk.co.ziazoo.injector.provider.IProvider;
	
	/**
	 * The <code>IMap</code> is key to the configuration of a Dawn 
	 * application.  For any class or interface within the application
	 * which Dawn will need to create an instance for there needs to exist
	 * a <code>IMap</code> instance (stored within the <code>IMapper</code>).
	 * 
	 * A <code>IMap</code> instance explains to the Dawn what it should instantiate
	 * when it is ask to provide the class found in the <code>clazz</code> property.
	 */ 
	public interface IMap
	{
		/**
		 * The <code>Class</code> object this is providing
		 * the mapping for
		 */ 
		function get clazz():Class;
		
		/**
		 * if you want to map your <code>clazz</code> to another Class
		 * (this could be a subclass or an implementation of the interface
		 * found in the <code>clazz</code> property) use the toClass method.
		 * The code below shows an example line in a configuration class which
		 * uses the toClass method to map a class one of its subclasses
		 * <pre>
		 *  mapper.map(Person).toClass(FunnyPerson);
		 * </pre>
		 * The above code explains to Dawn that whenever it is asked to provide
		 * a <code>Person</code> it should create and inject the subclass of 
		 * <code>Person</code>, the <code>FunnyPerson</code>.
		 * 
		 * @return the <code>IProvider</code> for this mapping
		 */  
		function toClass( clazz:Class ):IProvider;
		
		/**
		 * sometimes if does not make sense or it is not possible
		 * for Dawn to construct one of your depencencies, for example
		 * you may be useing some thrid party code which does not contain
		 * metadata explaining its depencencies.  Mappings to factories
		 * deal with these occations
		 */ 
		function toFactory( factory:Class ):IProvider;
		
		/**
		 * Offten you simple want Dawn to construct the class that it sees
		 * as a dependency. i.e. if you want Dawn to create a <code>Person</code>
		 * whenever it finds a depencency on a <code>Person</code>. When this is the case
		 * map the class to its self with the toSelf method
		 * 
		 * <pre>
		 *   mapper.map(Person).toSelf();
		 * </pre>
		 */ 
		function toSelf():IProvider;
		
		/**
		 * when you already have the instance of a class you want to be provided
		 * by Dawn to other classes that depend on it, use the toInstance method.  This is
		 * commonly used in flex applications to map a view component which has been
		 * created in MXML.
		 * 
		 * <pre>
		 *   mapper.map(MyView).toInstance(application.myView);
		 * </pre>
		 */
		function toInstance( object:Object ):IProvider;
		
		/**
		 * The <code>IProvider</code> that was created by the mapping
		 */ 
		function get provider():IProvider;
		
		/**
		 * returns true is this clazz has been mapped to a factory
		 */ 
		function get isFactory():Boolean;
	}
}