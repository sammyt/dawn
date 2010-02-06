package uk.co.ziazoo.injector
{	
	public interface IMappingBuilder
	{
		function to( clazz:Class ):IMappingBuilder;
		function toFactory( object:Object ):IMappingBuilder;
		function toInstance( object:Object ):IMappingBuilder;
		function named( name:String ):IMappingBuilder;
		function asSingleton():IMappingBuilder;
		function getMapping():IMapping;
	}
}