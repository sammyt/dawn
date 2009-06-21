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
		
		public function map( clazz:Class, provider:Class ):IMap
		{
			var map:IMap = new Map( clazz, provider );
			_maps.push( map );
			return map;
		}
	
		public function getObject( entryPoint:Class ):Object
		{
			var node:TreeNode = createNode( getMapByClass( entryPoint ) );
			return construct( node );;
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
						if( metadata.@name )
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
		
		internal function getMap( clazzName:String ):IMap
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

import uk.co.ziazoo.injector.IMap;
import flash.utils.describeType;
import flash.utils.Dictionary;

class Map implements IMap
{
	private var _clazz:Class;
	private var _provider:Class;
	private var _singleton:Boolean;
	private var _instance:Object;
	private var _accessors:Dictionary;
	
	public function Map( clazz:Class, provider:Class, singleton:Boolean = false )
	{
		_clazz = clazz;
		_provider = provider;
		_singleton = singleton;
		_accessors = new Dictionary();
	}
	
	public function get provider():Class
	{
		return _provider;
	}
	
	public function get providerName():String
	{
		return describeType( _provider ).@name;
	}
	
	public function get clazz():Class
	{
		return _clazz;
	}
	
	public function get clazzName():String
	{
		return describeType( _clazz ).@name;
	}
	
	public function get singleton():Boolean
	{
		return _singleton;
	}
	
	public function set singleton( value:Boolean ):void
	{
		_singleton = value;
	}
		
	public function provideInstance():Object
	{
		trace( "provideInstance", provider );
		if( singleton && _instance )
		{
			return _instance;
		}
		else if( singleton )
		{
			_instance = new provider();
			return _instance;
		}
		
		return new provider();
	}
	
	public function addAccessor( name:String, clazzName:String ):void
	{
		_accessors[ clazzName ] = name;
	}
	
	public function getAccessor( clazzName:String ):String
	{
		return _accessors[ clazzName ] as String;
	}
	
	public function toString():String
	{
		return "[Map provider=" + provider + "]";
	}	
}






