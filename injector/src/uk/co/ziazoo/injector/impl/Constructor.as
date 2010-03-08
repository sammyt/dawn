package uk.co.ziazoo.injector.impl 
{
	internal class Constructor
	{
		public var params:Array;
		public var metadatas:Array;
		
		public function Constructor()
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
    
    public function hasParams():Boolean
    {
      return params != null;
    }
	}
}

