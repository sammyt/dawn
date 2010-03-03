package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	internal class Injector implements IInjector
	{
		private var mapper:IMapper;
		private var dependencyFactory:DependencyFactory;
		private var injectionPointFactory:InjectionPointFactory;
    private var reflector:Reflector;
    
		public function Injector( dependencyFactory:DependencyFactory, mapper:IMapper,
		 	injectionPointFactory:InjectionPointFactory, reflector:Reflector )
		{
			this.dependencyFactory = dependencyFactory;
			this.injectionPointFactory = injectionPointFactory;
			this.mapper = mapper;
      this.reflector = reflector;
		}
		
		/**
		*	@inheritDoc
		*/	
		public function inject( object:Object ):Object
		{
			var mapping:IMapping = getMapping( object );
			var dependency:IDependency = dependencyFactory.forMapping( mapping );
			
			return create( dependency );
		}
		
		internal function create( dependency:IDependency ):Object
		{
      var reflection:Reflection = getReflection( dependency );
      
      var injectionPoint:IInjectionPoint = 
          injectionPointFactory.forConstructor( reflection.constructor );
      
      var dependencies:Array = [];
      for each( var child:IDependency in injectionPoint.getDependencies() )
      {
        create( child );
        dependencies.push( child );
      }
      
      var injector:ConstructorInjector = new ConstructorInjector( dependencies );
      
      injectMethodDependencies( dependency );
      injectPropertyDependencies( dependency );
      
			return dependency.getObject();
		}
    
    internal function injectPropertyDependencies( dependency:IDependency ):void
    {
      var reflection:Reflection = getReflection( dependency );
      
      var injectionPoints:Array = injectionPointFactory.forProperties( 
        reflection.properties );
      
      for each( var injectionPoint:PropertyInjectionPoint in injectionPoints )
      {
        for each( var child:IDependency in injectionPoint.getDependencies() )
        {
          create( child );
          
          var injector:InstancePropertyInjector = new InstancePropertyInjector(
            injectionPoint.getPropertyName(), child.getObject() );
          
          injector.inject( dependency.getObject() );
        }
      }
    }
    
    internal function injectMethodDependencies( dependency:IDependency ):void
    {
      var reflection:Reflection = getReflection( dependency );
      
      var injectionPoints:Array = injectionPointFactory.forMethods( 
        reflection.methods );
      
      for each( var injectionPoint:MethodInjectionPoint in injectionPoints )
      {
        var dependencies:Array = [];
        for each( var child:IDependency in injectionPoint.getDependencies() )
        {
          create( dependency );
          dependencies.push( child );
        }
        var injector:InstanceMethodInjector = new InstanceMethodInjector(
          injectionPoint.getMethodName(), dependencies );
        
        injector.inject( dependency.getObject() );
      }
    }
    
    private function getReflection( dependency:IDependency ):Reflection
    {
      var type:Class = dependency.getMapping().type;
      return reflector.getReflection( type ); 
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