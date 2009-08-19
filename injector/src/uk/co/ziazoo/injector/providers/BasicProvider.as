package uk.co.ziazoo.injector.providers
{
	public class BasicProvider extends AbstractProvider
	{
		protected var _instance:Object;
		
		public function BasicProvider( clazz:Class )
		{
			super( clazz );
		}
		
		override public function getInstance():Object
		{
			if( singleton )
			{
				if( _instance )
				{
					return _instance;
				}
				_instance = new clazz();
				return _instance;
			}
			else
			{
				return new clazz();
			}
			return null;
		}
	}
}