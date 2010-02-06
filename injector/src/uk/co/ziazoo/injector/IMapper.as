package uk.co.ziazoo.injector
{	
	public interface IMapper
	{
		function map( clazz:Class ):IMappingBuilder;
		
		function getProvider( mapping:IMapping ):IProvider;
	}
}