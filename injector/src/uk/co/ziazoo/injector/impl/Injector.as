package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	internal class Injector implements IInjector
	{
		private var mapper:IMapper;
		private var dependencyFactory:DependencyFactory;
		private var injectionPointFactory:InjectionPointFactory;
		
		public function Injector( dependencyFactory:DependencyFactory,
		 	injectionPointFactory:InjectionPointFactory, mapper:IMapper )
		{
			this.dependencyFactory = dependencyFactory;
			this.injectionPointFactory = injectionPointFactory;
			this.mapper = mapper;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function inject( object:Object ):Object
		{
			var mapping:IMapping = getMapping( object );
			var dependency:IDependency = dependencyFactory.forMapping( mapping );
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function install( configuration:IConfiguration ):void
		{
			configuration.configure( mapper );
		}
		
		public function getMapping( object:Object, name:String = "" ):IMapping
		{
			return mapper.getMapping( getClass( object ), name );
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