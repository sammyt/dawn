package uk.co.ziazoo.injector
{
	public interface IBuilder
	{
		function getObject( entryPoint:Class ):Object;
		
		function getMap( clazz:Class, name:String = null ):IMap;
		
		function getMapByName( className:String, name:String = null ):IMap;
	}
}