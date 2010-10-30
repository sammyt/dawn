package uk.co.ziazoo.injector.impl
{
  import flash.system.ApplicationDomain;

  import uk.co.ziazoo.injector.IEagerQueue;
  import uk.co.ziazoo.injector.IMapping;
  import uk.co.ziazoo.injector.IMappingBuilder;
  import uk.co.ziazoo.injector.IProvider;
  import uk.co.ziazoo.injector.IScope;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  public class MappingBuilder implements IMappingBuilder
  {
    private var mappings:Array;
    private var eagerQueue:IEagerQueue;
    private var detailsFactory:ITypeInjectionDetailsFactory;
    private var applicationDomain:ApplicationDomain;

    public function MappingBuilder(type:Class, eagerQueue:IEagerQueue, detailsFactory:ITypeInjectionDetailsFactory, applicationDomain:ApplicationDomain)
    {
      this.eagerQueue = eagerQueue;
      this.detailsFactory = detailsFactory;
      this.applicationDomain = applicationDomain;
      getMappings().push(new Mapping(type));
      to(type);
    }

    public function to(type:Class):IMappingBuilder
    {
      setProvider(new BasicProvider(type));
      return this;
    }

    public function and(type:Class):IMappingBuilder
    {
      var mapping:IMapping = new Mapping(type);
      mapping.name = getFirstMapping().name;
      mapping.provider = getFirstProvider();

      mappings.push(mapping);

      return this;
    }

    public function toFactory(factory:Class):IMappingBuilder
    {
      setProvider(new FactoryProvider(factory, detailsFactory.forType(factory)));
      return this;
    }

    public function toInstance(object:Object):IMappingBuilder
    {
      setProvider(new InstanceProvider(object, applicationDomain));
      asSingleton();
      return this;
    }

    public function named(name:String):IMappingBuilder
    {
      setName(name);
      return this;
    }

    public function inScope(scope:IScope):void
    {
      var provider:IProvider = getFirstProvider();
      setProvider(new ScopeWrapper(scope.wrap(provider), provider));
    }

    public function asSingleton():void
    {
      inScope(new SingletonScope());
    }

    private function setName(name:String):void
    {
      for each(var mapping:IMapping in mappings) {
        mapping.name = name;
      }
    }

    private function setProvider(provider:IProvider):void
    {
      for each(var mapping:IMapping in mappings) {
        mapping.provider = provider;
      }
    }

    public function asEagerSingleton():void
    {
      asSingleton();
      eagerQueue.push(getFirstMapping());
    }

    private function getFirstProvider():IProvider
    {
      return getFirstMapping().provider;
    }

    private function getFirstMapping():IMapping
    {
      return (mappings[0] as IMapping);
    }

    public function getMappings():Array
    {
      if (!mappings) {
        mappings = [];
      }
      return mappings;
    }

    public function get baseMapping():IMapping
    {
      return getFirstMapping();
    }
  }
}