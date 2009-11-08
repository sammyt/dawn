package uk.co.ziazoo.notifier 
{
	internal class Callback
	{
		private var _callback:Function;
		private var _type:Class;
		
		public function Callback( callback:Function, type:Class )
		{
			_callback = callback;
			_type = type;
		}
		
		public function isTriggeredBy( notification:Object ):Boolean
		{
			return notification is _type;
		}
		
		public function call( notification:Object ):void
		{
			_callback.apply( null, [ notification ] );
		}
		
		public function encapsulates( callback:Function, type:Class ):Boolean
		{
			if( callback == _callback
			 	&& type == _type )
			{
				return true;
			}
			return false;
		}
		
		internal function get type():Class
		{
			return _type;
		}
		
		internal function get callback():Function
		{
			return _callback;
		}
	}
}

