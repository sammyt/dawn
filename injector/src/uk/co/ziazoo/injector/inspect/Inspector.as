package uk.co.ziazoo.injector.inspect
{
	import de.polygonal.ds.TreeNode;
	
	import flash.utils.describeType;
	
	import uk.co.ziazoo.injector.mapping.IMap;
	import uk.co.ziazoo.injector.mapping.IMapper;
	
	public class Inspector implements IInspector
	{
		private var _mapper:IMapper;
		
		public function Inspector()
		{
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function getTree( map:IMap, parent:TreeNode=null ):TreeNode
		{
			var node:TreeNode = new TreeNode( map, parent );
			
			var clazz:Class = map.provider.clazz;
			var reflection:XML = describeType( clazz );
			var injects:XMLList = reflection.factory..metadata.(@name == "Inject");
			
			for each( var metadata:XML in injects )
			{
				var accessor:XML = metadata.parent();
				var name:String = null
				if( metadata.hasOwnProperty( "arg" ) )
				{
					name = metadata.arg.( @key=="name" ).@value;
				}
				// the provider has a dependency on a 
				// class/interface of type accessor.@type
				var childMap:IMap = mapper.getMapByName( accessor.@type, name );
				
				var optional:Boolean = false;
				if( accessor.metadata.arg.( @key=="optional" ).@value == "true" )
				{
					optional = true;  
				}
				
				if( !childMap
					&& optional == false )
				{
					throw new Error( "Could not provide dependencies for " + map.provider.clazz +
						" as no mapping could be found for " + accessor.@type );
				}
				
				if( childMap )
				{
					map.provider.addAccessor( accessor.@name, childMap.provider );
					getTree( childMap, node );	
				}
			}
			
			// does this object have a DependenciesInjected callback
			var callbacks:XMLList = reflection.factory.method.metadata.(@name == "DependenciesInjected");
			var callback:XML = callbacks.parent();
			
			if( callback )
			{
				var parameters:XMLList = callback.parameter;
				if( parameters.length() > 0 )
				{
					throw new Error( "DependenciesInjected callback in " + map.provider.clazz + " " +
						"requires " + parameters.length() + " argument(s). DependenciesInjected " +
						"calbacks must have no required arguments" );
				}
				map.provider.completionTrigger = callback.@name;
			}
			
			return node;
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function get mapper():IMapper
		{
			return _mapper;
		}
		
		public function set mapper(value:IMapper):void
		{
			_mapper = value;
		}
	}
}