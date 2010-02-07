package uk.co.ziazoo.injector.impl 
{
	import some.thing.Tree;
	import org.flexunit.Assert;
		
	public class ReflectorTest
	{
		public function ReflectorTest()
		{
		}
		
		[Test]
		public function getsInjectables():void
		{
			var reflector:Reflector = new Reflector( Tree );
			
			Assert.assertTrue( "has 1 method", reflector.methods.length == 1 );
			Assert.assertTrue( "has 2 props", reflector.properties.length == 2 );
			Assert.assertNotNull( "has constructor", reflector.constructor );
		}
	}
}

