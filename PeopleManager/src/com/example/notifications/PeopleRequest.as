package com.example.notifications
{
	import com.example.handlers.IPeopleRequestHandler;

	public class PeopleRequest extends ResponderCallback
	{
		public function PeopleRequest( result:Function )
		{
			super( result );
		}
		
		[InjectHandler]
		public function nextHandler( handler:IPeopleRequestHandler ):void
		{
			handler.retrieveAllPeople( this );
		}
	}
}