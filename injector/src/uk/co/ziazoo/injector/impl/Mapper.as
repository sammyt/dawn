package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IMappingBuilder;
	
	import flash.utils.getDefinitionByName;
	
	public class Mapper implements IMapper
	{
		internal var builders:Array;
		
		public function Mapper()
		{
			builders = [];
		}
		
		public function map( clazz:Class ):IMappingBuilder
		{
			var builder:IMappingBuilder = new MappingBuilder( clazz );
			builders.push( builder );
			return builder;
		}
		
		public function getMapping( type:Class, name:String = "" ):IMapping
		{
			var unNamed:IMapping;
			for each( var builder:IMappingBuilder in builders )
			{
				var mapping:IMapping = builder.mapping;
				
				if( mapping.type == type )
				{
					if( mapping.name == name )
					{
						return mapping;
					}
					else if( mapping.name == "" )
					{
						unNamed = mapping;
					}
				}
			}
			return unNamed;
		}
		
		public function getMappingFromQName( 
			qName:String, name:String = "" ):IMapping
		{
			var type:Class = getDefinitionByName( qName ) as Class;
			return getMapping( type, name );
		}
	}
}