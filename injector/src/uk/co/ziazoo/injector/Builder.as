package uk.co.ziazoo.injector
{
	import de.polygonal.ds.TreeNode;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public class Builder implements IBuilder, IMapper
	{
		private var _config:IConfig;
		private var _maps:Array;
		
		public function Builder( config:IConfig )
		{
			_config = config;
			_maps = new Array();
			_config.create( this );
		}
		
		public function map( clazz:Class ):IMap
		{
			var map:IMap = new Map( clazz );
			_maps.push( map );
			return map;
		}
		
		public function getMap( clazz:Class, name:String = null ):IMap
		{
			var noneNamed:IMap = null;
			for each( var map:IMap in _maps )
			{
				if( map.clazz == clazz )
				{
					if( name == map.provider.name )
					{
						return map;
					}
					else if( !map.provider.name )
					{
						noneNamed = map;
					}
				}
			}
			return noneNamed;
		}
		
		public function getMapByName( className:String, name:String = null ):IMap
		{
			return getMap( getDefinitionByName( className ) as Class, name );
		}
			
		
		public function getObject( entryPoint:Class ):Object
		{
			var node:TreeNode = createNode( getMap( entryPoint ) );
			trace( node.dump() );
			return null;
		}
		
		
		internal function createNode( map:IMap, parent:TreeNode = null ):TreeNode
		{
			var node:TreeNode = new TreeNode( map, parent );
			
			var clazz:Class = map.provider.clazz;
			for each( var accessor:XML in describeType( clazz ).factory.accessor )
			{
				if( accessor.hasOwnProperty( "metadata" ) )
				{
					for each( var metadata:XML in accessor.metadata )
					{
						if( metadata.@name == "Inject" )
						{
							var name:String = null
							if( metadata.hasOwnProperty( "arg" ) )
							{
								name = metadata.arg.( @key=="name" ).@value;
							}
							// the provider has a dependency on a 
							// class/interface of type accessor.@type
							createNode( getMapByName( accessor.@type, name ), node );
						}
					}
				}
			}
			return node;
		}
	}
}
