package uk.co.ziazoo.injector.impl
{	
	import org.flexunit.Assert;
	
	public class InjectablePropertyTest
	{	
		public function InjectablePropertyTest()
		{
		}
		
		[Test]
		public function reflectVariable():void
		{
			var variable:XML = <variable name="car" type="some.thing::Car">
	      <metadata name="Inject">
	        <arg key="name" value="fast"/>
	      </metadata>
	    </variable>;
			
			var prop:InjectableProperty = new InjectableProperty( variable );
			
			Assert.assertTrue( "found the name", prop.name == "car" );
			Assert.assertTrue( "found the type", prop.type == "some.thing::Car" );
			Assert.assertTrue( "one metadata", prop.metadata.length == 1 );
		}
		
		[Test]
		public function reflectAccessor():void
		{
			var accessor:XML = <accessor name="radio" access="writeonly" 
				type="some.thing::IRadio" declaredBy="some.thing::Tree">
	      <metadata name="Inject"/>
	    </accessor>
			
			var prop:InjectableProperty = new InjectableProperty( accessor );
			
			Assert.assertTrue( "found the name", prop.name == "radio" );
			Assert.assertTrue( "found the type", prop.type == "some.thing::IRadio" );
			Assert.assertTrue( "one metadata", prop.metadata.length == 1 );
		}
	}
}