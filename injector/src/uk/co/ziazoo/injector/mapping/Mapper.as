package uk.co.ziazoo.injector.mapping
{
	import flash.utils.getDefinitionByName;
	
	import uk.co.ziazoo.injector.IMapper;
	
	public class Mapper implements IMapper
	{
		private var _maps:Array;
		
		public function Mapper()
		{
			_maps = new Array();
		}

		/**
		 * @inheritDoc
		 */
		public function map( clazz:Class ):IMap
		{
			var map:IMap = new Map( clazz );
			_maps.push( map );
			return map;
		}
		
		/**
		 * @inheritDoc
		 */
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
			
			if( !noneNamed )
			{
				var autoMap:IMap = this.map( clazz );
				autoMap.toSelf();
				return autoMap;
			}
			
			return noneNamed;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getMapByName( className:String, name:String = null ):IMap
		{
			return getMap( getDefinitionByName( className ) as Class, name );
		}
	}
}