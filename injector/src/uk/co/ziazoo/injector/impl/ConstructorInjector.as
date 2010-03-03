package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	
	public class ConstructorInjector
	{
		private var dependencies:Array;
		
		public function ConstructorInjector( dependencies:Array )
		{
			this.dependencies = dependencies;
		}
	}
}

