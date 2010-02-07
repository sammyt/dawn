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
			var clazz:Class;
			if( object is Class )
			{
				clazz = object as Class;
			}
			else
			{
				clazz = getClass( object );
			}
			
			//var root:Dependency = new Dependency( getMapping( clazz ) );
			
			return null;
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
			return Array;
		}
	}
}