package com.example.notifications
{
	import com.example.handlers.IAddPersonHandler;
	import com.example.model.Person;

	public class AddPersonRequest
	{
		private var _person:Person;
		
		public function AddPersonRequest( person:Person )
		{
			_person = person;
		}
		
		[InjectHandler]
		public function nextHandler( handler:IAddPersonHandler ):void
		{
			handler.addPerson( _person );
		}
	}
}