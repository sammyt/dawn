package uk.co.ziazoo.injector.impl
{	
	import org.flexunit.Assert;
	
	public class PropertyReflectionTest
	{	
		public var reflector:Reflector;
		
		public function PropertyReflectionTest()
		{
		}
		
		[Before]
		public function setUp():void
		{
			reflector = new Reflector();
		}
		
		[After]
		public function tearDown():void
		{
			reflector = null;
		}
		
		[Test]
		public function reflectVariable():void
		{
			var variable:XML = <variable name="car" type="some.thing::Car">
	      <metadata name="Inject">
	        <arg key="name" value="fast"/>
	      </metadata>
	    </variable>;
			
			var prop:Property = reflector.parseProperty( variable );
			
			Assert.assertTrue( "found the name", prop.name == "car" );
			Assert.assertTrue( "found the type", prop.type == "some.thing::Car" );
			Assert.assertTrue( "one metadata", prop.metadatas.length == 1 );
		}
		
		[Test]
		public function reflectAccessor():void
		{
			var accessor:XML = <accessor name="radio" access="writeonly" 
				type="some.thing::IRadio" declaredBy="some.thing::Tree">
	      <metadata name="Inject"/>
	    </accessor>
			
			var prop:Property = reflector.parseProperty( accessor );
			
			Assert.assertTrue( "found the name", prop.name == "radio" );
			Assert.assertTrue( "found the type", prop.type == "some.thing::IRadio" );
			Assert.assertTrue( "one metadata", prop.metadatas.length == 1 );
		}
	}
}