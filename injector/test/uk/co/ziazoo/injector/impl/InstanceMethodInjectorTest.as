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
			var method:Method = new Method();
			method.name = "injectLeaf";
			
			var leaf:Parameter = new Parameter();
			leaf.type = "some.thing.::Leaf";
			leaf.index = 1;
			leaf.optional = false;
			
			method.addParameter( leaf );
			
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