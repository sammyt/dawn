package uk.co.ziazoo.injector.impl
{	
	public class InjectableProperty
	{
		public var name:String;
		public var type:String;
		public var metadata:Array;
		
		public function InjectableProperty( prop:XML )
		{
			name = prop.@name;
			type = prop.@type;
			
			metadata = [];
			for each( var m:XML in prop.metadata )
			{
				metadata.push( new Metadata( m ) );
			}
		}
	}
}