package uk.co.ziazoo.injector.impl 
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	internal class Reflection 
	{
		public var type:Class;
		public var properties:Array;
		public var methods:Array;
		public var constructor:Constructor;
    
    private var _providerMethod:Method;
    private var _completeMethod:Method;
		
		public function Reflection()
		{
		}
		
		public function addProperty( property:Property ):void
		{
			if( !properties )
			{
				properties = [];
			}
			properties.push( property );
		}
		
		public function addMethod( method:Method ):void
		{
			if( !methods )
			{
				methods = [];
			}
			methods.push( method );
		}
    
    public function setProviderMethod( provider:Method ):void
    {
      _providerMethod = provider;
    }
    
    public function hasProviderMethod():Boolean
    {
      return _providerMethod != null;
    }
    
    public function get providerMethod():Method
    {
      return _providerMethod;
    }
    
    public function setCompleteMethod( callback:Method ):void
    {
      _completeMethod = callback;
    }
    
    public function hasCompleteMethod():Boolean
    {
      return _completeMethod != null;
    }
    
    public function get completeMethod():Method
    {
      return _completeMethod;
    }
	}
}
