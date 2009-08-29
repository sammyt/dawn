package com.example.notifications
{
	import com.example.handlers.IPersonRequestHandler;

	public class PersonRequest
	{
		private var _name:String;
		
		public function PersonRequest( name:String )
		{
			_name = name;
		}
		
		[InjectHandler]
		public function nextHandler( handler:IPersonRequestHandler ):void
		{
			handler.retrievePerson( _name );
		}
	}
}