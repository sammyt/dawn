package uk.co.ziazoo.injector.providers
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public class FactoryProvider extends AbstractProvider
	{
		private var _factory:Object;
		
		public function FactoryProvider( clazz:Class )
		{
			super( clazz );
		}
		
		override public function get clazz():Class
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
							//method.@returnType
							return getDefinitionByName( method.@returnType ) as Class;
						}
					}
				}
			}
			return null;
		}
		
		override public function createInstance():Object
		{
			_factory = new _class();
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
	}
}