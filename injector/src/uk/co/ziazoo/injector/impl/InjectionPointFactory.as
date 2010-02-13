package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	
	public class InjectionPointFactory implements IInjectionPointFactory
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
				var injectionPoint:InjectionPoint = new InjectionPoint();
				injectionPoints.push( injectionPoint );
			}
			return injectionPoints;
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
					parameter.type, getNameForParam( method.metadata, parameter ) );
				
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
	}
}

