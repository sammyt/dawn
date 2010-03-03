package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IProvider;
	import uk.co.ziazoo.injector.IScope;
	
	public class SingletonScope implements IScope, IProvider
	{
		private var provider:IProvider;
		private var instance:Object;
		
		public function SingletonScope()
		{
		}
		
		public function getObject():Object
		{
			if( !instance )
			{
				instance = provider.getObject();
			}
			return instance;
		}
		
		public function wrapInScope( provider:IProvider ):IProvider
		{
			this.provider = provider;
			return this;
		}
	}
}

