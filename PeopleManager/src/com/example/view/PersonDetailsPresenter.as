package com.example.view
{
	import com.example.handlers.IPersonRecievedHandler;
	import com.example.model.Person;

	public class PersonDetailsPresenter implements IPersonRecievedHandler
	{
		private var _details:PersonDetails;
		
		public function PersonDetailsPresenter( details:PersonDetails )
		{
			_details = details;
		}
		
		public function onPersonRevieved( person:Person ):void
		{
			_details.person = person;
		}
	}
}