package uk.co.ziazoo.injector.impl 
{
  import uk.co.ziazoo.injector.IProvider;
	
	internal class BasicProvider implements IProvider
	{	
		internal var type:Class;
    private var dependencies:Array;
		
		public function BasicProvider( type:Class )
		{
			this.type = type;
		}
		
		public function getObject():Object
		{
			return new type();
		}
    
    public function setDependencies( dependencies:Array ):void
    {
      this.dependencies = dependencies;
    }
	}
}

