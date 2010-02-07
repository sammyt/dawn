package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IMappingBuilder;
	import uk.co.ziazoo.injector.IProvider;
	
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
				var mapping:IMapping = builder.getMapping();
				
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
	}
}