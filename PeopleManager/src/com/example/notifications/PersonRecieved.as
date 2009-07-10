package com.example.notifications
{
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;

	public class PersonRecieved
	{
		private var _person:Person;
		
		public function PersonRecieved( person:Person )
		{
			_person = person;
		}
		
		[InjectHandler]
		public function nextHandler( handler:IPersonRecievedHandler ):void
		{
			handler.onPersonRevieved( _person );
		}
	}
}