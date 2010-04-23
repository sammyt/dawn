package uk.co.ziazoo.injector.impl
{
  import flash.utils.Dictionary;
  import flash.utils.describeType;

  internal class Reflector
  {
    private var cache:Dictionary;

    public function Reflector()
    {
    }

    public function getReflection(type:Class):Reflection
    {
      if (!cache)
      {
        cache = new Dictionary();
      }

      if (!cache[ type ])
      {
        cache[ type ] = reflect(type);
      }
      return cache[ type ] as Reflection;
    }

    private function reflect(type:Class):Reflection
    {
      var source:XML = describeType(type);
      var reflection:Reflection = new Reflection();
      reflection.type = type;

      addProperties(reflection, source.descendants("variable"));
      addProperties(reflection, source.descendants("accessor"));
      var methods:XMLList = source.descendants("method");
      addMethods(reflection, methods);
      addProviderMethod(reflection, methods);
      addCompleteMethod(reflection, methods);

      reflection.constructor = parseConstructorWithHack(XML(source.factory), type);

      return reflection;
    }

    internal function parseConstructorWithHack(reflection:XML, type:Class):Constructor
    {
      var params:XMLList = reflection.constructor.parameter;
      if (params.length() > 0)
      {
        try
        {
          var args:Array = [];
          for (var i:int = 0; i < params.length(); i++)
          {
            args.push(null);
          }
          InstanceCreator.create(type, args);
          reflection = XML(describeType(type).factory);
        }
        catch(e:Error)
        {
        }
      }
      return parseConstructor(reflection);
    }

    internal function parseConstructor(reflection:XML):Constructor
    {
      var constructor:Constructor = new Constructor();

      for each(var p:XML in reflection.constructor.parameter)
      {
        constructor.addParameter(parseParameter(p));
      }

      for each(var m:XML in reflection.metadata)
      {
        constructor.addMetadata(parseMetadata(m));
      }
      return constructor;
    }

    internal function parseProperty(prop:XML):Property
    {
      var property:Property = new Property();
      property.name = prop.@name;
      property.type = prop.@type;

      for each(var m:XML in prop.metadata)
      {
        property.addMetadata(parseMetadata(m));
      }
      return property;
    }

    internal function parseMethod(reflection:XML):Method
    {
      var method:Method = new Method();
      method.name = reflection.@name;

      for each(var p:XML in reflection.parameter)
      {
        method.addParameter(parseParameter(p));
      }

      for each(var m:XML in reflection.metadata)
      {
        method.addMetadata(parseMetadata(m));
      }

      return method;
    }

    internal function parseMetadata(reflection:XML):Metadata
    {
      var metadata:Metadata = new Metadata();
      metadata.name = reflection.@name;

      for each(var p:XML in reflection.arg)
      {
        metadata.addProperty(p.@key, p.@value);
      }
      return metadata;
    }

    internal function parseParameter(reflection:XML):Parameter
    {
      var parameter:Parameter = new Parameter();
      parameter.index = parseInt(reflection.@index);
      parameter.type = reflection.@type;
      parameter.optional = reflection.@optional == "true";
      return parameter;
    }

    private function addProperties(reflection:Reflection, source:XMLList):void
    {
      var withInjects:XMLList = source.metadata.( @name == "Inject" );
      for each(var p:XML in withInjects)
      {
        reflection.addProperty(parseProperty(p.parent()));
      }
    }

    private function addMethods(reflection:Reflection, source:XMLList):void
    {
      var withInjects:XMLList = source.metadata.( @name == "Inject" );
      for each (var m:XML in withInjects)
      {
        reflection.addMethod(parseMethod(m.parent()));
      }
    }

    private function addProviderMethod(reflection:Reflection, source:XMLList):void
    {
      var provider:XMLList = source.metadata.( @name == "Provider" );

      if (provider.length() == 1)
      {
        reflection.setProviderMethod(parseMethod(provider[0].parent()));
      }
    }

    private function addCompleteMethod(reflection:Reflection, source:XMLList):void
    {
      var postConstruct:XMLList = source.metadata.( @name == "PostConstruct" );

      if (postConstruct.length() == 1)
      {
        reflection.setCompleteMethod(parseMethod(postConstruct[0].parent()));
      }
      else
      {
        var depsInjected:XMLList = source.metadata.(
          @name == "DependenciesInjected" );
        if (depsInjected.length() == 1)
        {
          reflection.setCompleteMethod(parseMethod(depsInjected[0].parent()));
        }
      }
    }
  }
}