package uk.co.ziazoo.injector.providers
{
	public class BasicProvider extends AbstractProvider
	{
		public function BasicProvider( clazz:Class )
		{
			super( clazz );
		}
		
		override public function createInstance():Object
		{
			return new clazz();
		}
	}
}