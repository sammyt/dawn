package uk.co.ziazoo.injector 
{
	public interface IDependency
	{
		function getMapping():IMapping;
		function getParent():IInjectionPoint;
	}
}

