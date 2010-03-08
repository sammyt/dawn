package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IProvider;
	
	public class SingletonScope implements IProvider
	{
		private var provider:IProvider;
		private var instance:Object;
		
		public function SingletonScope( provider:IProvider )
		{
      this.provider = provider;
		}
    
    public function get type():Class
    {
      return provider.type;
    }
    
    public function withDependencies( dependencies:Array ):void
    {
      provider.withDependencies( dependencies );
    }
    
    public function get requiresInjection():Boolean
    {
      if( instance )
      {
        return false;
      }
      else
      {
        return provider.requiresInjection;
      }
    }
    
		public function getObject():Object
		{
			if( !instance )
			{
				instance = provider.getObject();
			}
			return instance;
		}
	}
}

