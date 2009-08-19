package uk.co.ziazoo.injector.providers
{
	import flash.utils.describeType;

	public class FactoryProvider extends AbstractProvider
	{
		private var _factory:Object;
		
		public function FactoryProvider( clazz:Class )
		{
			super( clazz );
			asSingleton();
		}
		
		override public function invokeGenerator():Object
		{
			var reflection:XML = describeType( _factory );
			
			for each( var method:XML in reflection.method )
			{
				if( method.hasOwnProperty( "metadata" ) )
				{
					for each( var metadata:XML in method.metadata )
					{
						if( metadata.@name == "Provider" )
						{
							var fnt:Function = _factory[ method.@name ] as Function;
							return fnt.apply( _factory );
						}
					}
				}
			}
			return null;
		}
		
		override public function getInstance():Object
		{
			if( singleton )
			{
				if( _factory )
				{
					return _factory;
				}
				_factory = new clazz();
				return _factory;	
			}
			else
			{
				throw new Error( "FactoryProvider must be a singleton" );
			}
		}
	}
}