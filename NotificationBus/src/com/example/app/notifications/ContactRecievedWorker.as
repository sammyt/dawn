package com.example.app.notifications
{
	import com.example.app.Contact;

	public class ContactRecievedWorker
	{
		public var contact:Contact;
		
		public function ContactRecievedWorker( contact:Contact )
		{
			this.contact = contact;
		}
		
		[InjectorMethod]
		public function nextHandler( handler:IHandleContactRevieved ):void
		{
			handler.onContact( contact );
		}
	}
}