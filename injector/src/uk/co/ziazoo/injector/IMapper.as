package uk.co.ziazoo.injector
{
	public interface IMapper
	{
		function map( clazz:Class, provider:Class ):IMap;
	}
}