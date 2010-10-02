package uk.co.ziazoo.injector.impl
{
  import uk.co.ziazoo.fussy.model.Constructor;
  import uk.co.ziazoo.fussy.model.Metadata;
  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.fussy.model.Parameter;
  import uk.co.ziazoo.fussy.model.Property;
  import uk.co.ziazoo.injector.IDependencyFactory;
  import uk.co.ziazoo.injector.IInjectionPoint;
  import uk.co.ziazoo.injector.IMapper;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;

  internal class InjectionPointFactory
  {
    private var dependencyFactory:IDependencyFactory;
    private var mapper:IMapper;

    public function InjectionPointFactory(
      dependencyFactory:IDependencyFactory, mapper:IMapper)
    {
      this.dependencyFactory = dependencyFactory;
      this.mapper = mapper;
    }

    public function forProperties(details:ITypeInjectionDetails):Array
    {
      var injectionPoints:Array = [];
      for each(var property:Property in details.properties)
      {
        var qName:String = property.type;
        var name:String = getNameForProperty(property);

        var mapping:IMapping = mapper.getMappingForQName(qName, name);

        if (!mapping)
        {
          var metadata:Metadata = getInjectMetadata(property.metadata);
          if (!metadata.properties["optional"])
          {
            mapping = mapper.justInTimeMapByQName(qName, name).baseMapping;
          }
        }

        if (mapping)
        {
          injectionPoints.push(forProperty(property, mapping.provider));
        }

      }
      return injectionPoints;
    }

    private function getInjectMetadata(metadata:Array):Metadata
    {
      for each(var item:Metadata in metadata)
      {
        if (item.name == "Inject")
        {
          return item;
        }
      }
      return null;
    }

    internal function forProperty(property:Property,
      provider:IProvider):IInjectionPoint
    {
      var injectionPoint:PropertyInjectionPoint =
        new PropertyInjectionPoint(property);

      injectionPoint.setDependency(dependencyFactory.forProvider(provider));

      return injectionPoint;
    }

    public function forMethods(details:ITypeInjectionDetails):Array
    {
      var injectionPoints:Array = [];
      for each(var method:Method in details.methods)
      {
        injectionPoints.push(forMethod(method));
      }
      return injectionPoints;
    }

    internal function forMethod(method:Method):IInjectionPoint
    {
      var injectionPoint:MethodInjectionPoint =
        new MethodInjectionPoint(method);

      for each(var parameter:Parameter in method.parameters)
      {
        var qName:String = parameter.type;
        var name:String = getNameForParam(method.metadata, parameter);

        var mapping:IMapping = mapper.getMappingForQName(qName, name);

        if (!mapping)
        {
          if (!parameter.optional)
          {
            mapping = mapper.justInTimeMapByQName(qName, name).baseMapping;
          }
        }
        if (mapping)
        {
          injectionPoint.addDependency(
            dependencyFactory.forProvider(mapping.provider));
        }

      }
      return injectionPoint;
    }

    public function forConstructor(details:ITypeInjectionDetails):IInjectionPoint
    {
      var constructor:Constructor = details.constructor;
      var injectionPoint:ConstructorInjectionPoint =
        new ConstructorInjectionPoint(constructor);

      for each(var parameter:Parameter in constructor.parameters)
      {
        var qName:String = parameter.type;
        var name:String = getNameForParam(details.metadata, parameter);

        var mapping:IMapping = mapper.getMappingForQName(qName, name);

        if (!mapping)
        {
          if (!parameter.optional)
          {
            mapping = mapper.justInTimeMapByQName(qName, name).baseMapping;
          }
        }
        if (mapping)
        {
          injectionPoint.addDependency(
            dependencyFactory.forProvider(mapping.provider));
        }
      }
      return injectionPoint;
    }

    internal function getNameForParam(metadatas:Array, param:Parameter):String
    {
      for each(var metadata:Metadata in metadatas)
      {
        if (metadata.name == "Named")
        {
          var index:int = parseInt(metadata.properties["index"]);
          if (index == param.index)
          {
            return metadata.properties["name"];
          }
        }
      }
      return "";
    }

    internal function getNameForProperty(property:Property):String
    {
      var fromInject:String;
      for each(var metadata:Metadata in property.metadata)
      {
        if (metadata.name == "Inject")
        {
          if (metadata.properties
            && metadata.properties["name"])
          {
            fromInject = metadata.properties["name"];
          }
        }
        if (metadata.name == "Named")
        {
          return metadata.properties["name"];
        }
      }
      return fromInject;
    }
  }
}

