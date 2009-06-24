package uk.co.ziazoo.injector
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class Map extends AbstractMap implements IMap
	{
		public function Map( clazz:Class, provider:Class, name:String = null )
		{
			_clazz = clazz;
			_provider = provider;
			_name = name;
			_accessors = new Dictionary();
		}
	}
}