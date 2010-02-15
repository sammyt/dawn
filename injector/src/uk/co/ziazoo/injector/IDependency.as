package uk.co.ziazoo.injector 
{
	public interface IDependency
	{
		function getMapping():IMapping;
		
		function getParent():IInjectionPoint;
		
		function getInjectionPoints():Array;
		
		function getObject():Object;
		
		function get parameterIndex():int;
		function set parameterIndex(value:int):void;
	}
}

