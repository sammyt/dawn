package uk.co.ziazoo.injector
{	
	public interface IMapper
	{
		function map( clazz:Class ):IMappingBuilder;
		
		function getMapping( type:Class, name:String = "" ):IMapping;
	}
}