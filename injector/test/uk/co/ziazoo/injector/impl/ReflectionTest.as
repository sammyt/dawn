package uk.co.ziazoo.injector.impl 
{
	import some.thing.Tree;
	import org.flexunit.Assert;
		
	public class ReflectionTest
	{
		public function ReflectionTest()
		{
		}
		
		[Test]
		public function getsInjectables():void
		{
			var reflection:Reflection = new Reflection( Tree );
			
			Assert.assertTrue( "has 1 method", reflection.methods.length == 1 );
			Assert.assertTrue( "has 2 props", reflection.properties.length == 2 );
			Assert.assertNotNull( "has constructor", reflection.constructor );
		}
	}
}

