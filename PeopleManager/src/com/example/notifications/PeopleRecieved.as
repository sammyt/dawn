package com.example.notifications
{
	import com.example.handlers.IPeopleRecievedHandler;
	
	import mx.collections.IList;

	public class PeopleRecieved
	{
		private var _people:IList;
		
		public function PeopleRecieved( people:IList )
		{
			_people = people;
		}
		
		[InjectHandler]
		public function nextHandler( handler:IPeopleRecievedHandler ):void
		{
			handler.onPeopleRevieved( _people );
		}
	}
}