package com.example.model
{
  import flash.utils.setTimeout;

  /**
	 * Dummy service object. 
	 */ 
	public class MockContactsService implements IContactsService
	{
		private var _contacts:Array;
		
		public function MockContactsService()
		{
			_contacts = 
				[
					new Contact("Sam Williams"),
					new Contact("Rebecca Howes"),
					new Contact("Bob Smith"),
					new Contact("Joe Bloggs")
				];
		}
		
		/**
		 * @inheritDoc
		 */ 
		public function getContacts( callback:IAsyncCallback ):void
		{
			// fake rpc call delay
			setTimeout( function():void
			{
				callback.onResult( _contacts );
			}, 500 );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addContact( contact:Contact, callback:IAsyncCallback ):void
		{
			_contacts.push( contact );
			
			// fake rpc call delay
			setTimeout( function():void
			{
				callback.onResult( true );
			}, 500 );
		}
	}
}