package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IProvider;
	
	internal class BasicProvider implements IProvider
	{	
		internal var type:Class;
		
		public function BasicProvider( type:Class )
		{
			this.type = type;
		}
		
		public function getObject():Object
		{
			return null;
		}
	}
}

