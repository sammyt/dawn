package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IDependency;
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IInjectionPoint;
	
	public class Dependency implements IDependency
	{
		private var mapping:IMapping;
		private var injectionPoint:IInjectionPoint;
		private var injectionPoints:Array;
		private var reflection:Reflection;
		private var _parameterIndex:int;
		
		public function Dependency( mapping:IMapping, reflection:Reflection,
			injectionPoint:IInjectionPoint = null )
		{
			this.mapping = mapping;
			_parameterIndex = 0;
			if( injectionPoint )
			{
				this.injectionPoint = injectionPoint;
			}
		}
		
		public function getObject():Object
		{
			return mapping.provider.getObject();
		}
		
		public function getInjectionPoints():Array
		{
			if( injectionPoints )
			{
				return injectionPoints;
			}
			injectionPoints = [];
			append( injectionPoints, reflection.properties );
			append( injectionPoints, reflection.methods );
			append( injectionPoints, [reflection.constructor] );
			
			return injectionPoints;
		}
		
		internal function append( source:Array, items:Array ):void
		{
			for each( var obj:Object in items )
			{
				source.push( obj );
			}
		}
		
		public function getMapping():IMapping
		{
			return mapping;
		}
		
		public function getParent():IInjectionPoint
		{
			return injectionPoint;
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

