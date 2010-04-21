package com.example.model
{
  public interface IContactsService
	{
		/**
		 * retrieves all the contacts from the server
		 * 
		 * @param callback:IAsyncCallback triggered with result and fault methods
		 */ 
		function getContacts( callback:IAsyncCallback ):void;
		
		/**
		 * adds a contact to the contacts list on the server
		 * 
		 * @param contact:Contact the contact to add
		 * @param callback:IAsyncCallback triggered with result and fault methods
		 */ 
		function addContact( contact:Contact, callback:IAsyncCallback ):void;
	}
}