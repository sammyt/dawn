package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IProvider;
	import uk.co.ziazoo.injector.IScope;
	
	internal class BasicProvider implements IProvider
	{	
		internal var type:Class;
		
		private var _scope:IScope;
		
		public function BasicProvider( type:Class )
		{
			this.type = type;
		}
		
		public function getObject():Object
		{
			return null;
		}
		
		public function get scope():IScope
		{
			return _scope;
		}
		
		public function set scope(value:IScope):void 
		{
			_scope = value;
		}
	}
}

