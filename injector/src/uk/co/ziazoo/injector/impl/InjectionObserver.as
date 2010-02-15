package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class InjectionObserver implements IInjectionObserver
	{
		public function InjectionObserver( dependency:IDependency )
		{
		}
		
		/**
		*	@inheritDoc
		*/	
		public function onDependencyResolved( dependency:IDependency ):void
		{
			
		}
	}
}