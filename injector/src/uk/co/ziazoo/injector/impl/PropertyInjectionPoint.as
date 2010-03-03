package uk.co.ziazoo.injector.impl
{
	import uk.co.ziazoo.injector.*;
		
	public class PropertyInjectionPoint implements IInjectionPoint
	{
		private var dependencies:Array;
		private var property:Property;
    
		public function PropertyInjectionPoint( property:Property )
		{
      this.property = property;
		}
		
    public function getPropertyName():String
    {
      return property.name;  
    }
    
		public function getDependencies():Array
		{
			return dependencies;
		}
		
		public function isOptional():Boolean
		{
			return false;
		}
		
		public function addObserver( observer:IInjectionObserver ):void
		{
			
		}
		
		public function setDependency( dependency:IDependency ):void
		{
			dependencies = [ dependency ];
		}
	}
}