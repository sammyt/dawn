package com.example.commands
{
	import com.example.model.CreateContact;
	import com.example.model.GetContacts;
	import com.example.model.IContactsService;
	
	import uk.co.ziazoo.notifier.AsyncCallback;
	import uk.co.ziazoo.notifier.INotificationBus;

	public class CreateContactCommand
	{
		[Inject]
		/**
		 * the service object for contacts
		 */ 
		public var service:IContactsService;
		
		[Inject]
		public var bus:INotificationBus;
		
		public function CreateContactCommand()
		{
		}
		
		/**
		 * called when this command is executed.  The name of the method is not important
		 * only that is has the [Execute] metadata and a parameter of type CreateContact
		 * 
		 * Adds the contact found in the notification to the list of contacts.  When the contact
		 * has been added the GetContacts notification is triggered to update the contacts list
		 * 
		 * @param note:CreateContact the notification that will trigger this command to execute
		 */  
		[Execute] public function execute( note:CreateContact ):void
		{
			service.addContact( note.newContact, new AsyncCallback( 
				function( added:Boolean ):void
				{
					bus.trigger( new GetContacts() );
				})
			);
		}
	}
}