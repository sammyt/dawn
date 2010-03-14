package uk.co.ziazoo.injector.impl
{	
	import org.flexunit.Assert;
	
	public class ConstructorReflectionTest
	{
		public var reflector:Reflector;
		
		public function ConstructorReflectionTest()
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
		public function canParseWithMetadata():void
		{
			var reflection:XML = <factory type="some.thing::Tree">
			    <metadata name="Named">
			      <arg key="arg" value="ground"/>
			      <arg key="name" value="earth"/>
			    </metadata>
			    <metadata name="Inject"/>
			    <extendsClass type="Object"/>
			    <constructor>
			      <parameter index="1" 
							type="some.thing::Ground" optional="false"/>
			    </constructor>
			    <variable name="car" type="some.thing::Car">
			      <metadata name="Inject">
			        <arg key="name" value="fast"/>
			      </metadata>
			    </variable>
			    <method name="injectLeaf" 
						declaredBy="some.thing::Tree" returnType="void">
			      <parameter index="1" type="some.thing::Leaf" optional="false"/>
			      <metadata name="Inject"/>
			    </method>
			    <accessor name="radio" 
						access="writeonly" type="some.thing::IRadio" 
						declaredBy="some.thing::Tree">
			      <metadata name="Inject"/>
			    </accessor>
			  </factory>;
				
			var constructor:Constructor = reflector.parseConstructor( reflection );
			
			Assert.assertTrue( "one param", constructor.params.length == 1 );
			Assert.assertTrue( "two metadatas", constructor.metadatas.length == 2 );
		}
		
		[Test]
		public function canParseWithoutMetadata():void
		{
			var reflection:XML = <factory type="some.thing::Tree">
			    <extendsClass type="Object"/>
			    <constructor>
			      <parameter index="1" 
							type="some.thing::Ground" optional="false"/>
			    </constructor>
			    <variable name="car" type="some.thing::Car">
			      <metadata name="Inject">
			        <arg key="name" value="fast"/>
			      </metadata>
			    </variable>
			    <method name="injectLeaf" 
						declaredBy="some.thing::Tree" returnType="void">
			      <parameter index="1" type="some.thing::Leaf" optional="false"/>
			      <metadata name="Inject"/>
			    </method>
			    <accessor name="radio" 
						access="writeonly" type="some.thing::IRadio" 
						declaredBy="some.thing::Tree">
			      <metadata name="Inject"/>
			    </accessor>
			  </factory>;
				
			var constructor:Constructor = reflector.parseConstructor( reflection );
			
			Assert.assertTrue( "one param", constructor.params.length == 1 );
			Assert.assertNull( "no metadata", constructor.metadatas );
		}
	}
}