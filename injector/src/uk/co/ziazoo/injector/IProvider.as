package uk.co.ziazoo.injector
{	
	public interface IProvider
	{
    function get type():Class;
    
		function getObject():Object;
    
    function withDependencies( dependencies:Array ):void;
	}
}