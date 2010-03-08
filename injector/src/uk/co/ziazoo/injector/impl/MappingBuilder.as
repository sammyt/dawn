package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IMappingBuilder;
	import uk.co.ziazoo.injector.IScope;
	
	public class MappingBuilder implements IMappingBuilder
	{
		private var clazz:Class;
		private var _mapping:IMapping;
    private var reflector:Reflector;
		
		public function MappingBuilder( clazz:Class, reflector:Reflector )
		{
			this.clazz = clazz;
      this.reflector = reflector;
		}
		
		public function to( type:Class ):IMappingBuilder
		{
			mapping.provider = new BasicProvider( type );	
			return this;
		}
		
		public function toFactory( factory:Class ):IMappingBuilder
		{
      mapping.provider = new FactoryProvider( factory, reflector );
			return this;
		}
		
		public function toInstance( object:Object ):IMappingBuilder
		{
			return null;
		}
		
		public function named( name:String ):IMappingBuilder
		{
			mapping.name = name;
			return this;
		}
		
		public function inScope( scope:IScope ):void
		{
			// mapping.provider = scope.wrapInScope( mapping.provider );
		}
		
		public function asSingleton():void
		{
			var singleton:SingletonScope = new SingletonScope();
			inScope( singleton );
		}
		
		public function get mapping():IMapping
		{
			if( !_mapping )
			{
				_mapping = new Mapping( clazz );
			}
			return _mapping;
		}
	}
}