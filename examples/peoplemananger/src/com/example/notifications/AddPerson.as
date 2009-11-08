package com.example.notifications
{
	import com.example.handlers.IAddPersonHandler;
	import com.example.model.Person;
	
	import mx.rpc.IResponder;

	public class AddPerson
	{
		private var person:Person;
		
		public function AddPerson( person:Person )
		{
			this.person = person;
		}
	}
}