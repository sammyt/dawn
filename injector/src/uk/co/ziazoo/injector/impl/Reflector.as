package uk.co.ziazoo.injector.impl 
{
	import flash.utils.describeType;
	
	internal class Reflector 
	{
		private var type:Class;
		
		public var properties:Array;
		public var methods:Array;
		public var constructor:Constructor;
		
		public function Reflector( type:Class )
		{
			this.type = type;
			
      var reflection:XML = describeType( type );
      
			properties = [];
			addProperties( reflection.descendants( "variable" ) );
			addProperties( reflection.descendants( "accessor" ) );
			
			methods = [];
			addMethods( reflection.descendants( "method" ) );
			
			constructor = new Constructor( XML( reflection.factory ) );
		}
		
		internal function addProperties( reflection:XMLList ):void
		{
			var withInjects:XMLList = reflection.metadata.( @name == "Inject" );
			for each( var p:XML in withInjects )
			{
				properties.push( new Property( p.parent() ) );
			}
		}
		
		internal function addMethods( reflection:XMLList ):void
		{
			var withInjects:XMLList = reflection.metadata.( @name == "Inject" );
			for each ( var m:XML in withInjects )
      {
				methods.push( new Method( m.parent() ) );
			}
		}
	}
}
