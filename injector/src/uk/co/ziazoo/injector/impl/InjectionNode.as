package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class InjectionNode
	{
		private var dependency:IDependency;
		private var injectionNodes:Array;
		
		public function InjectionNode( dependency:IDependency )
		{
			this.dependency = dependency;
		}
		
		public function createInjectionPoints():void
		{
			injectionNodes = [];
			
			
		}
	}
}