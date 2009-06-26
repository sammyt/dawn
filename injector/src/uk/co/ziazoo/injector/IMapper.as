package uk.co.ziazoo.injector
{
	public interface IMapper
	{
		function map( clazz:Class ):IMap;
		
		function getMap( clazz:Class, name:String = null ):IMap;
		
		function getMapByName( className:String, name:String = null ):IMap;
	}
}