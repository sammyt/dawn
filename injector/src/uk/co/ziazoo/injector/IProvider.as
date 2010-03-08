package uk.co.ziazoo.injector
{	
	public interface IProvider
	{
    function get type():Class;
    
    function withDependencies( dependencies:Array ):void;
    
    function get requiresInjection():Boolean;
    
    function getObject():Object;
	}
}