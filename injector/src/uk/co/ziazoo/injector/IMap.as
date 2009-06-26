package uk.co.ziazoo.injector
{
	import uk.co.ziazoo.injector.providers.IProvider;

	public interface IMap
	{
		function get clazz():Class;
		
		function toClass( clazz:Class ):IProvider;
		
		function toFactory( factory:Class ):IProvider;
		
		function toSelf():IProvider;
		
		function get provider():IProvider;
	}
}