package uk.co.ziazoo.injector
{
	import de.polygonal.ds.DListIterator;
	import de.polygonal.ds.TreeNode;
	
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	public class ReflectionParser implements IMapper, IBuilder
	{
		private var _config:IMappingConfiguration;
		private var _maps:Array;
		
		public function ReflectionParser( config:IMappingConfiguration )
		{
			_config = config;
			_maps = new Array();
			_config.create( this );
		}
		
		/**
		*	@inheritDoc
		*/	
		public function map( clazz:Class, provider:Class = null, name:String = null ):IMap
		{
			// if there is no provider the class is assumed
			// to provided for itself
			provider = provider ? provider : clazz;
			
			var map:IMap = getMapByClass( clazz ) ? 
				getMapByClass( clazz ) : new Map( clazz, provider, name );
			
			_maps.push( map );
			return map;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function mapToFactory( clazz:Class, provider:Function, name:String = null ):IMap
		{
			
		}
		
		public function getObject( entryPoint:Class ):Object
		{
			var node:TreeNode = createNode( getMapByClass( entryPoint ) );
			trace( node.dump() );
			return construct( node );
		}
		
		internal function construct( node:TreeNode ):Object
		{
			var itr:DListIterator = node.children.getIterator() as DListIterator;
			
			var map:IMap = node.data as IMap;
			
			var obj:Object = map.provideInstance(); 
			
			var children:Array = [];
			
			for ( ; itr.valid(); itr.forth() )
			{
				var child:Object = construct( TreeNode( itr.data ) );
				
				obj[ map.getAccessor( getQualifiedClassName( child ) ) ] = child;
			}
			
			return obj;
		}
		
		internal function createNode( map:IMap, parent:TreeNode = null ):TreeNode
		{
			var node:TreeNode = new TreeNode( map, parent );
			
			for each( var accessor:XML in describeType( map.provider ).factory.accessor )
			{
				if( accessor.hasOwnProperty( "metadata" ) )
				{
					for each( var metadata:XML in accessor.metadata )
					{
						if( metadata.@name == "Inject" )
						{
							var childMap:IMap = getMap( accessor.@type );
							map.addAccessor( accessor.@name, childMap.providerName );
							createNode( childMap, node );
						}
					}
				}
			}
			return node;
		}
		
		internal function getMap( clazzName:String, name:String = null ):IMap
		{
			for each( var map:IMap in _maps )
			{
				if( map.clazzName == clazzName )
				{
					return map;
				}
			}
			return null;
		}
		
		internal function getMapByClass( clazz:Class ):IMap
		{
			return getMap( getQualifiedClassName( clazz ) );
		}
	}
}
