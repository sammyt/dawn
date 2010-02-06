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
		
		public function getProvider( mapping:IMapping ):IProvider
		{
			return null;
		}
	}
}