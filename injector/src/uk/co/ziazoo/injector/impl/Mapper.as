package uk.co.ziazoo.injector.impl
{	
	import flash.utils.getDefinitionByName;
	
	import uk.co.ziazoo.injector.IMapper;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IMappingBuilder;
	
	public class Mapper implements IMapper
	{
		internal var builders:Array;
		private var reflector:Reflector;
    
		public function Mapper( reflector:Reflector )
		{
			builders = [];
      this.reflector = reflector;
		}
		
		public function map( clazz:Class ):IMappingBuilder
		{
			var builder:IMappingBuilder = new MappingBuilder( clazz, reflector );
			builders.push( builder );
      
      builder.to( clazz );
      
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
      
      if( !unNamed )
      {
        unNamed = map( type ).to( type ).mapping;
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