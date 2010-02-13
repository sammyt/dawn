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
		public function injectLeaf( leaf:Leaf, bacon:Array ):void
		{
			
		}
		
		[Inject(name="fast")]
		public var car:Car;
		
		public var thing:Engine;
		
		[Inject]
		public function set radio(value:IRadio):void 
		{
		}
	}
}

