package uk.co.ziazoo.injector.impl
{	
	import org.flexunit.Assert;
	import flash.utils.Dictionary;
	
	public class MetadataTest
	{
		public function MetadataTest()
		{
		}
		
		[Test]
		public function reflectNoArgs():void
		{
			var reflect:XML = <metadata name="Inject"/>;
			
			var metadata:Metadata = new Metadata( reflect );
			
			Assert.assertTrue( "named inject", metadata.name == "Inject" );
		}
		
		[Test]
		public function reflectWithArgs():void
		{
			var reflect:XML = <metadata name="Inject">
        <arg key="name" value="fast"/>
				<arg key="thing" value="woo"/>
      </metadata>;
			
			var metadata:Metadata = new Metadata( reflect );
			
			Assert.assertTrue( "named inject", metadata.name == "Inject" );
			
			var props:Dictionary = metadata.properties;
			
			Assert.assertTrue( "has prop name", props["name"] == "fast" );
			Assert.assertTrue( "has prop thing", props["thing"] == "woo" );
		}
	}
}