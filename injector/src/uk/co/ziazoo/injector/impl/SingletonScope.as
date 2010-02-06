package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IScope;
	
	public class SingletonScope implements IScope
	{
		public function SingletonScope()
		{
		}
		
		public function getObject():Object
		{
			return null;
		}
	}
}

