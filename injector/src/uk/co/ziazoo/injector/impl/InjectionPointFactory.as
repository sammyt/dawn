package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	
	public class InjectionPointFactory
	{
		private var dependencyFactory:DependencyFactory;
		private var mapper:IMapper;
		
		public function InjectionPointFactory( 
			dependencyFactory:DependencyFactory, mapper:IMapper )
		{
			this.dependencyFactory = dependencyFactory;
			this.mapper = mapper;
		}
		
		public function forProperties( properties:Array ):Array
		{
			var injectionPoints:Array = [];
			for each( var property:Property in properties )
			{
				injectionPoints.push( forProperty( property ) );
			}
			return injectionPoints;
		}
		
		public function forProperty( property:Property ):IInjectionPoint
		{
			var injectionPoint:PropertyInjectionPoint = 
				new PropertyInjectionPoint( property );
			
			var mapping:IMapping = mapper.getMappingFromQName( 
				property.type, getNameForProperty( property ) );
			
			injectionPoint.setDependency( 
				dependencyFactory.forMapping( mapping , injectionPoint ) );
			
			return injectionPoint;
		}
		
		public function forMethods( methods:Array ):Array
		{
			var injectionPoints:Array = [];
			for each( var method:Method in methods )
			{
				injectionPoints.push( forMethod( method ) );
			}
			return injectionPoints;
		}
		
		public function forMethod( method:Method ):IInjectionPoint
		{
			var injectionPoint:MethodInjectionPoint = 
				new MethodInjectionPoint( method );
				
			for each( var parameter:Parameter in method.params )
			{
				var mapping:IMapping = mapper.getMappingFromQName( 
					parameter.type, getNameForParam( method.metadatas, parameter ) );
				
				injectionPoint.addDependency( 
					dependencyFactory.forMapping( mapping, injectionPoint ) );
			}
			return injectionPoint;
		}
		
		public function forConstructor( constructor:Constructor ):IInjectionPoint
		{
			var injectionPoint:ConstructorInjectionPoint = 
				new ConstructorInjectionPoint( constructor );
			
			for each( var parameter:Parameter in constructor.params )
			{
				var mapping:IMapping = mapper.getMappingFromQName( 
					parameter.type, getNameForParam( constructor.metadatas, parameter ) );
				
				injectionPoint.addDependency( 
					dependencyFactory.forMapping( mapping, injectionPoint ) );
			}
			return injectionPoint;
		}
		
		internal function getNameForParam( metadatas:Array, param:Parameter ):String
		{
			for each( var metadata:Metadata in metadatas )
			{
				if( metadata.name == "Named" )
				{
					var index:int = parseInt( metadata.properties["index"] );
					if( index == param.index )
					{
						return metadata.properties["name"];
					}
				}
			}
			return "";
		}
		
		internal function getNameForProperty( property:Property ):String
		{
			for each( var metadata:Metadata in property.metadatas )
			{
				if( metadata.name == "Named" )
				{
					return metadata.properties["name"];
				}
			}
			return "";
		}
	}
}

