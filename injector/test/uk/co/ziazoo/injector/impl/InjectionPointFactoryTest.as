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
		
		[Test]
		public function getInjectionForMethod():void
		{
			var injectionPoint:IInjectionPoint = factory.forMethod( createMethod() );
			Assert.assertNotNull( "we get a injectionPoint", injectionPoint );
			
			var deps:Array = injectionPoint.getDependencies();
			Assert.assertTrue( "has one dep", 1 == deps.length );
		}
	}
}

