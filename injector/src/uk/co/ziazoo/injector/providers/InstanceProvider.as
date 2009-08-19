package uk.co.ziazoo.injector.providers 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class InstanceProvider extends AbstractProvider 
	{
		private var _instance:Object;
		
		public function InstanceProvider( instance:Object )
		{
			super( getDefinitionByName( 
					getQualifiedClassName( instance ) ) as Class );
			_instance = instance;
			
			asSingleton();
		}
		
		override public function createInstance():Object
		{
			return _instance;
		}
	}	
}

