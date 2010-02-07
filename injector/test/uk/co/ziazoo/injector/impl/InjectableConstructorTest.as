package uk.co.ziazoo.injector.impl
{	
	import org.flexunit.Assert;
	
	public class InjectableConstructorTest
	{
		public function InjectableConstructorTest()
		{
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
				
			var constructor:InjectableConstructor = 
				new InjectableConstructor( reflection );
			
			Assert.assertTrue( "one param", constructor.params.length == 1 );
			Assert.assertTrue( "two metadatas", constructor.metadata.length == 2 );
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
				
			var constructor:InjectableConstructor = 
				new InjectableConstructor( reflection );
			
			Assert.assertTrue( "one param", constructor.params.length == 1 );
			Assert.assertTrue( "no metadata", constructor.metadata.length == 0 );
		}
	}
}