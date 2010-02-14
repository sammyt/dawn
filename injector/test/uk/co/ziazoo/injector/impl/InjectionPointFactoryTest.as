package uk.co.ziazoo.injector.impl 
{
	import org.flexunit.Assert;
	
	import uk.co.ziazoo.injector.*;
	
	public class InjectionPointFactoryTest
	{
		private var factory:InjectionPointFactory;
		
		public function InjectionPointFactoryTest()
		{
		}
		
		[Before]
		public function setUp():void
		{
			var mapper:IMapper = new Mapper();
			factory = new InjectionPointFactory( new DependencyFactory(), mapper );
		}
		
		[After]
		public function tearDown():void
		{
			factory = null;
		}
		
		public function createMethod():Method
		{
			var reflect:XML = <method name="injectLeaf" 
				declaredBy="some.thing::Tree" returnType="void">
	      <parameter index="1" type="some.thing::Leaf" optional="false"/>
	      <metadata name="Inject"/>
	    </method>;
	
			return new Method( reflect );
		}
		
		public function createProperty():Property
		{
			var variable:XML = <variable name="car" type="some.thing::Car">
		    <metadata name="Inject">
		      <arg key="name" value="fast"/>
		    </metadata>
		  </variable>;
      
			return new Property( variable );
		}
		
		public function createConstructor():Constructor
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
			
			
			return new Constructor( reflection );
		}
		
		[Test]
		public function getInjectionForMethod():void
		{
			var injectionPoint:IInjectionPoint = factory.forMethod( createMethod() );
			Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
			
			var deps:Array = injectionPoint.getDependencies();
			Assert.assertTrue( "has one dep", 1 == deps.length );
		}
		
		[Test]
		public function getInjectionForProperty():void
		{
			var injectionPoint:IInjectionPoint = 
				factory.forProperty( createProperty() );
				
			Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
			
			var deps:Array = injectionPoint.getDependencies();
			Assert.assertTrue( "has one deps", 1 == deps.length );
		}
		
		[Test]
		public function getInjectionForConstructor():void
		{
			var injectionPoint:IInjectionPoint = 
				factory.forConstructor( createConstructor() );
				
			Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
			
			var deps:Array = injectionPoint.getDependencies();
			Assert.assertTrue( "has one deps", 1 == deps.length );
		}
	}
}

