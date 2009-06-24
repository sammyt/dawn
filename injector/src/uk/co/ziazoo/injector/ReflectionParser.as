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
			
			var map:IMap = new Map( clazz, provider, name );
			
			_maps.push( map );
			return map;
		}
		
		/**
		 *	@inheritDoc
		 */	
		public function mapToFactoryFunction( clazz:Class, factory:Function, name:String = null ):IMap
		{
			return null;
		}
		
		/**
		 *	@inheritDoc
		 */	
		public function mapToFactoryClass( clazz:Class, factory:Class, name:String = null ):IMap
		{
			var map:IMap = new ProviderClassMap( clazz, factory, name );
			_maps.push( map );
			return map;
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
			
			var children:Array = [];
			
			// create the dependencies
			for ( ; itr.valid(); itr.forth() )
			{
				var child:Object = construct( TreeNode( itr.data ) );
				children.push( child );
			}
			
			var obj:Object = map.provideInstance();
			
			// set the dependencies on the object
			for each( var c:Object in children )
			{
				obj[ map.getAccessor( getQualifiedClassName( c ) ) ] = c;
			}
			
			if( map.isProviderFactory )
			{
				// return the generated object
				// by invoking the [provider] method
				return invokeProviderMethod( obj );
			}
			
			return obj;
		}
		
		internal function invokeProviderMethod( factory:Object ):Object
		{
			var reflection:XML = describeType( factory );
			for each( var method:XML in reflection.method )
			{
				if( method.hasOwnProperty( "metadata" ) )
				{
					for each( var metadata:XML in method.metadata )
					{
						if( metadata.@name == "Provider" )
						{
							trace( method.@name );
							var fnt:Function = factory[ method.@name ] as Function;
							return fnt.apply( factory );
						}
					}
				}
			}
			
			return null;
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
							var name:String = null
							if( metadata.hasOwnProperty( "arg" ) )
							{
								name = metadata.arg.( @key=="name" ).@value;
							}
							var childMap:IMap = getMap( accessor.@type, name );
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
			var noneNamed:IMap = null;
			
			for each( var map:IMap in _maps )
			{
				if( map.clazzName == clazzName )
				{
					if( name == map.name )
					{
						return map;
					}
					else if( !map.name )
					{
						noneNamed = map;
					}
				}
			}
			return noneNamed;
		}
		
		internal function getMapByClass( clazz:Class ):IMap
		{
			return getMap( getQualifiedClassName( clazz ) );
		}
	}
}
