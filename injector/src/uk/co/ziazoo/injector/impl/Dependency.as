package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IDependency;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IInjectionPoint;
	
	public class Dependency implements IDependency
	{
		private var _mapping:IMapping;
		private var _injectionPoint:IInjectionPoint;
		
		public function Dependency( mapping:IMapping )
		{
			_mapping = mapping;
		}
		
		public function get mapping():IMapping
		{
			return _mapping;
		}
		
		public function get injectionPoint():IInjectionPoint
		{
			return _injectionPoint;
		}
	}
}

