package uk.co.ziazoo.injector.impl
{
	import flash.utils.Dictionary;
		
	public class Reflector
	{
		private var cache:Dictionary;
		
		public function Reflector()
		{
		}
		
		public function getReflection( type:Class ):Reflection
		{
			if( !cache )
			{
				cache = new Dictionary();
			}
			
			if( !cache[ type ] )
			{
				cache[ type ] = new Reflection( type );
			}
			return cache[ type ] as Reflection;
		}
	}
}