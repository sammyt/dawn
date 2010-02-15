package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	
	public class InstanceMethodInjector implements IInstanceInjector
	{
		private var method:Method;
		private var dependencies:Array;
		
		public function InstanceMethodInjector( method:Method, dependencies:Array )
		{
			this.method = method;
			this.dependencies = dependencies;
		}
		
		public function inject( instance:Object ):void
		{
			var args:Array = [];
			
			for each( var dependency:IDependency in dependencies ) 
			{
				args.push( dependency.getObject() );
			}
			
			var fnt:Function = instance[ method.name ] as Function;
			
			fnt.apply( instance, args );
		}
	}
}

