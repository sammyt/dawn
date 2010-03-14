package some.thing 
{
	[Inject]
	public class Tree
	{
		public var leaf:Leaf;
		
		public function Tree( ground:Ground )
		{
		}
		
		[Inject]
		public function injectLeaf( leaf:Leaf ):void
		{
			this.leaf = leaf;
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

