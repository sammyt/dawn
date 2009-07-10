package com.example.notifications
{
	import com.example.handlers.IPeopleRequestHandler;

	public class PeopleRequest
	{
		public function PeopleRequest()
		{
		}
		
		[InjectHandler]
		public function nextHandler( handler:IPeopleRequestHandler ):void
		{
			handler.retrieveAllPeople();
		}
	}
}