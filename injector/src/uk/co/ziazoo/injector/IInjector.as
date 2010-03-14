package uk.co.ziazoo.injector
{	
	public interface IInjector
	{
		function inject( object:Object ):Object;
		function install( configuration:IConfiguration ):void;
    function map( clazz:Class ):IMappingBuilder;
	}
}