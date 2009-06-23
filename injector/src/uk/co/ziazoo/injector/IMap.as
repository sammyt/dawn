package uk.co.ziazoo.injector
{
	public interface IMap
	{
		/**
		*	The class whose map of provider
		*	this object represents
		*/	
		function get clazz():Class;
		
		/**
		*	the output of getQualifiedClassName on the clazz
		*/	
		function get clazzName():String;
		
		/**
		*	The scope of this class
		*/	
		function get singleton():Boolean;		
		function set singleton( value:Boolean ):void;

		
		function provideInstance():Object;
		
		// function addAccessor( name:String, clazzName:String ):void;
		// function getAccessor( clazzName:String ):String;
	}
}