package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	import some.thing.*;
	import org.flexunit.*;
	
	public class InstanceMethodInjectorTest
	{
		private var injector:InstanceMethodInjector;
		
		public function InstanceMethodInjectorTest()
		{
		}
		
		[Before]
		public function setUp():void
		{
			var reflect:XML = <method name="injectLeaf" 
				declaredBy="some.thing::Tree" returnType="void">
		    <parameter index="1" type="some.thing::Leaf" optional="false"/>
		    <metadata name="Inject"/>
		  </method>;
      
			var method:Method = new Method( reflect );
			
			var dependencies:Array = [ 
				new MockDependency( new Leaf() ) ];
			
			injector = new InstanceMethodInjector( method, dependencies );
		}
		
		[After]
		public function tearDown():void
		{
			injector = null;
		}
		
		[Test]
		public function doesItInject():void
		{
			var tree:Tree = new Tree( null );
			injector.inject( tree );
			Assert.assertNotNull( "has a leaf", tree.leaf );
		}
	}
}