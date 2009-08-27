package uk.co.ziazoo.injector.construct
{
	import de.polygonal.ds.DListIterator;
	import de.polygonal.ds.TreeNode;
	
	import uk.co.ziazoo.injector.mapping.IMap;
	
	public class Constructor implements IConstructor
	{
		public function Constructor()
		{
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function construct( root:TreeNode ):Object
		{
			var itr:DListIterator = root.children.getIterator() as DListIterator;
			
			// get the map for this node
			var map:IMap = root.data as IMap;
			
			// have we already created this object?
			if( map.provider.singleton
				&& map.provider.hasDependencies )
			{
				return map.provider.getInstance(); 
			}
			
			// create the dependencies			
			var children:Array = [];
			for ( ; itr.valid(); itr.forth() )
			{
				var node:TreeNode = TreeNode( itr.data );
				var child:Object = construct( node );
				children.push( new MapWithInstance( node.data as IMap, child ) );
			}
			
			var obj:Object = map.provider.getInstance();
			
			for each( var pair:MapWithInstance in children )
			{
				if( !pair.map.isFactory )
				{
					obj[ map.provider.getAccessor( pair.map.provider ) ] = pair.instance;
				}
				else
				{
					obj[ map.provider.getAccessor( pair.map.provider ) ] = pair.map.provider.invokeGenerator();
				}
			}
			
			// object is now created and dependencies have been injected
			map.provider.onDependenciesInjected();
			
			if( map.provider.hasCompletionTrigger )
			{
				var trigger:Function = obj[ map.provider.completionTrigger ];
				trigger.apply( obj );
			}
			
			return obj;
		}
	}
}
import uk.co.ziazoo.injector.mapping.IMap;

class MapWithInstance
{
	public var map:IMap;
	public var instance:Object;
	
	public function MapWithInstance( map:IMap, instance:Object )
	{
		this.map = map;
		this.instance = instance;
	}
}