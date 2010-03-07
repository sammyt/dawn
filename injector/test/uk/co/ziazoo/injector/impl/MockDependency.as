package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class MockDependency implements IDependency
	{
		private var object:Object;
		private var _parameterIndex:int = 0;
		
		public function MockDependency( object:Object, index:int = 0 )
		{
			this.object = object;
			parameterIndex = index;
		}
		
		public function getMapping():IMapping
		{
			return null;
		}
    
		public function getParent():IInjectionPoint
		{
			return null;
		}
    
    public function getProvider():IProvider
    {
      return null;
    }
    
		public function getInjectionPoints():Array
		{
			return null
		}
    
		public function getObject():Object
		{
			return object;
		}
		
		public function get parameterIndex():int
		{
			return _parameterIndex;
		}
		
		public function set parameterIndex(value:int):void 
		{
			_parameterIndex = value;
		}
	}
}