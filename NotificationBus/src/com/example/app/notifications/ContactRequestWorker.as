package com.example.app.notifications
{
	public class ContactRequestWorker
	{
		private var _id:int;
		
		public function ContactRequestWorker( id:int )
		{
			_id = id;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		[InjectorMethod]
		public function nextHandler( handler:IHandleContactRequest ):void
		{
			handler.onContactRequest( id );	
		}
	}
}