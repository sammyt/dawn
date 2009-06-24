package uk.co.ziazoo.injector
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	public class ProviderClassMap extends AbstractMap implements IMap
	{
		public function ProviderClassMap( clazz:Class, provider:Class, name:String = null )
		{
			_clazz = clazz;
			_provider = provider;
			_name = name;
			_accessors = new Dictionary();
			_isGenerator = true;
		}
		
		override public function get providerName():String
		{
			for each( var method:XML in describeType( provider ).factory.method )
			{
				if( method.hasOwnProperty( "metadata" ) )
				{
					for each( var metadata:XML in method.metadata )
					{
						if( metadata.@name == "Provider" )
						{
							return method.@returnType;
						}
					}
				}
			}
			return null;
		}
	}	
}