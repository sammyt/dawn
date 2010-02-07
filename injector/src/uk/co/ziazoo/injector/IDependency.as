package uk.co.ziazoo.injector 
{
	public interface IDependency
	{
		function get mapping():IMapping;
		function getParent():IInjectionPoint;
	}
}

