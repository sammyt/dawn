package uk.co.ziazoo.injector.construct
{
	import de.polygonal.ds.TreeNode;
	
	/**
	 * Given a <code>TreeNode</code> which explains the depencencies
	 * of a given class this constructor will recurse through the 
	 * providers requesting the instances and injecting them
	 */ 
	public interface IConstructor
	{
		/**
		 * creates the instance described by the tree
		 */ 
		function construct( root:TreeNode ):Object;
	}
}