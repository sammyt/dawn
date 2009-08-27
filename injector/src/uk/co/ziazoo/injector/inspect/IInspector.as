package uk.co.ziazoo.injector.inspect
{
	import de.polygonal.ds.TreeNode;
	
	import uk.co.ziazoo.injector.mapping.IMap;
	import uk.co.ziazoo.injector.IMapper;
	
	/**
	 * The IInspectors job is to perform reflection on a class
	 * and recursivly build up a tree of of <code>IMap<code>'s which
	 * describes the dependency tree of an object.
	 */ 
	public interface IInspector
	{
		/**
		 * for a given <code>IMap<code> returns the <code>TreeNode</code>
		 * of <code>IMaps</code>'s which describes the dependencies needed
		 * to create the class the map represents
		 */ 
		function getTree( map:IMap, parent:TreeNode = null ):TreeNode;
		
		/**
		 * a reference to the <code>IMapper</code> this application
		 * is using
		 */ 
		function get mapper():IMapper;
		function set mapper( value:IMapper ):void; 
	}
}