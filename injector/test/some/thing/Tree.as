package some.thing 
{
	[Inject]
	[Named(arg="ground", name="earth")]
	public class Tree
	{
		
		public function Tree( ground:Ground )
		{
		}
		
		[Inject]
		public function injectLeaf( leaf:Leaf ):void
		{
			
		}
		
		[Inject(name="fast")]
		public var car:Car;
		
		[Inject]
		public function set radio(value:IRadio):void 
		{
		}
	}
}

