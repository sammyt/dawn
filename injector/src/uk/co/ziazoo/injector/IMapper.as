package uk.co.ziazoo.injector
{
	public interface IMapper
	{
		function map( clazz:Class, provider:Class = null, name:String = null ):IMap;
	}
}