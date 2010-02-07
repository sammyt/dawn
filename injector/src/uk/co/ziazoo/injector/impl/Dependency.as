package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IDependency;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IInjectionPoint;
	
	public class Dependency implements IDependency
	{
		internal var mapping:IMapping;
		internal var injectionPoint:IInjectionPoint;
		
		public function Dependency( mapping:IMapping, 
			injectionPoint:IInjectionPoint = null )
		{
			this.mapping = mapping;
			if( parent )
			{
				this.injectionPoint = injectionPoint;
			}
		}
		
		public function getMapping():IMapping
		{
			return mapping;
		}
		
		public function getParent():IInjectionPoint
		{
			return injectionPoint;
		}
	}
}

