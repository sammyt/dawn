package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.IMapping;
	import uk.co.ziazoo.injector.IMappingBuilder;
	
	public class MappingBuilder implements IMappingBuilder
	{
		private var clazz:Class;
		private var singleton:Boolean;
		private var name:String;
		private var mapping:IMapping;
		
		public function MappingBuilder( clazz:Class )
		{
			this.clazz = clazz;
		}
		
		public function to( type:Class ):IMappingBuilder
		{
			getMapping().provider = new BasicProvider( type );	
			return this;
		}
		
		public function toFactory( object:Object ):IMappingBuilder
		{
			return null;
		}
		
		public function toInstance( object:Object ):IMappingBuilder
		{
			return null;
		}
		
		public function named( name:String ):IMappingBuilder
		{
			getMapping().name = name;
			return this;
		}
		
		public function asSingleton():IMappingBuilder
		{
			getMapping().provider.scope = new SingletonScope();
			return null;
		}
		
		public function getMapping():IMapping
		{
			if( !mapping )
			{
				mapping = new Mapping( clazz );
			}
			return mapping;
		}
	}
}