package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public interface IInjectionPointFactory
	{
		function forProperties( properties:Array ):Array;
		function forMethods( methods:Array ):Array;
		function forMethod( method:Method ):IInjectionPoint;
	}
}