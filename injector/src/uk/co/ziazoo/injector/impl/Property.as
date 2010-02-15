package uk.co.ziazoo.injector.impl
{	
	public class Property
	{
		public var name:String;
		public var type:String;
		public var metadatas:Array;
		
		public function Property()
		{
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