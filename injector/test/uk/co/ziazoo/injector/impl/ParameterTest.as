package uk.co.ziazoo.injector.impl
{
	import org.flexunit.Assert;
		
	public class ParameterTest
	{
		public function ParameterTest()
		{
		}
		
		[Test]
		public function simpleParam():void
		{
			var reflection:XML = 
				<parameter index="1" type="some.thing::Leaf" optional="false"/>;
			
			var param:Parameter = new Parameter( reflection );
			
			Assert.assertTrue( "gets index", param.index == 1 );
			Assert.assertTrue( "gets type", param.type == "some.thing::Leaf" );
			Assert.assertTrue( "gets index", param.optional == false );
		}
	}
}