package uk.co.ziazoo.injector.impl 
{
	public class Constructor
	{
		public var params:Array;
		public var metadata:Array;
		
		public function Constructor( factory:XML )
		{
			params = [];
			for each( var p:XML in factory.constructor.parameter )
			{
				params.push( new Parameter( p ) );
			}
			
			metadata = [];
			for each( var m:XML in factory.metadata )
			{
				metadata.push( new Metadata( m ) );
			}
		}
	}
}

