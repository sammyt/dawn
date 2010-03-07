package uk.co.ziazoo.injector.impl 
{
  import uk.co.ziazoo.injector.IDependency;
  import uk.co.ziazoo.injector.IProvider;
	
	internal class BasicProvider implements IProvider
	{	
		private var _type:Class;
    
    private var params:Array;
    
		public function BasicProvider( type:Class )
		{
			_type = type;
		}
		
		public function getObject():Object
		{
			return InstanceCreator.create( _type, params );
		}
    
    public function withDependencies( dependencies:Array ):void
    {
      params = [];
      for each( var dependency:IDependency in dependencies )
      {
        params.push( dependency.getObject() );
      }
    }
    
    public function get type():Class
    {
      return _type;
    }
	}
}

