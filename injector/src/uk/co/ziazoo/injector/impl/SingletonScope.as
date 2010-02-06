package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IScope;
	import uk.co.ziazoo.injector.IProvider;
	import uk.co.ziazoo.injector.IMapping;
	
	public class SingletonScope implements IScope
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
		
		public function scopeMapping( mapping:IMapping ):void
		{
			provider = mapping.provider;
			mapping.provider = this;
		}
	}
}

