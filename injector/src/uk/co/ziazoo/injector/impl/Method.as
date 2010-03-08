package uk.co.ziazoo.injector.impl
{	
	public class Method
	{
		public var name:String;
		public var params:Array;
		public var metadatas:Array;
    
		public function Method()
		{
		}
		
		public function addParameter( parameter:Parameter ):void
		{
			if( !params )
			{
				params = [];
			}
			params.push( parameter );
		}
		
		public function addMetadata( metadata:Metadata ):void
		{
			if( !metadatas )
			{
				metadatas = [];
			}
			metadatas.push( metadata );
		}
	}
}