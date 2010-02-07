package uk.co.ziazoo.injector 
{
	public interface IDependency
	{
		function get mapping():IMapping;
		function get injectionPoint():IInjectionPoint;
	}
}

