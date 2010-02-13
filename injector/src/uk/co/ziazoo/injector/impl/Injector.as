package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class Injector implements IInjector
	{
		private var _mapper:IMapper;
		
		public function Injector()
		{
		}
		
		/**
		*	@inheritDoc
		*/	
		public function inject( object:Object ):Object
		{
			var mapping:IMapping = getMapping( getClass( object ) );
			var dependency:IDependency = new Dependency( mapping );
			
			// magic
			
			return null;
		}
		
		private function createInjectionPoints( type:Class ):Array
		{
			var reflection:Reflection = new Reflection( type );
			var injectionPoints:Array = [];
			
			/*append( injectionPoints, 
				InjectionPoint.forProperties( reflection.properties ) );*/
			
			return null;
		}
		
		internal function append( destination:Array, source:Array ):void
		{
			for each( var item:Object in source )
			{
				destination.push( item );
			}
		}
		
		/**
		*	@inheritDoc
		*/	
		public function install( configuration:IConfiguration ):void
		{
			configuration.configure( mapper );
		}
		
		public function getMapping( type:Class, name:String = "" ):IMapping
		{
			return mapper.getMapping( type, name );
		}
		
		public function get mapper():IMapper
		{
			if( !_mapper )
			{
				_mapper = new Mapper();
			}
			return _mapper;
		}
		
		internal function getClass( object:Object ):Class
		{
			if( object is Class )
			{
				return object as Class;
			}
			else
			{
				return null;
			}
		}
	}
}