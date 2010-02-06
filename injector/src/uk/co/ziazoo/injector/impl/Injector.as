package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.IInjector;
	import uk.co.ziazoo.injector.IConfiguration;	
	
	public class Injector implements IInjector
	{
		public function Injector()
		{
		}
		
		/**
		*	@inheritDoc
		*/	
		public function inject( object:Object ):Object
		{
			return null;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function install( configuration:IConfiguration ):void
		{
			
		}
	}
}