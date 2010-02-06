package uk.co.ziazoo.injector
{	
	public interface IProvider
	{
		function getObject():Object;
		
		function get scope():IScope;
		function set scope(value:IScope):void;
	}
}