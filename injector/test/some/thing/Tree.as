package some.thing 
{
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

