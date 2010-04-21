package com.example.commands
{
  import com.example.model.GetContacts;
  import com.example.model.GotContacts;
  import com.example.model.IContactsService;

  public class GetContactsCommand
	{
		[Inject]
		/**
		 * the service object for contacts
		 */ 
		public var service:IContactsService;
		
		[Inject]
		public var bus:INotificationBus;
		
		public function GetContactsCommand()
		{
		}
		
		/**
		 * called when this command is executed.  The name of the method is not important
		 * only that is has the [Execute] metadata and a parameter of type GetContacts
		 * 
		 * retrieves the contacts from the server asynchronously then triggers the GotContacts
		 * noifications with the new list of contacts 
		 * 
		 * @param note:GetContacts the notification that will trigger this command to execute
		 */  
		[Execute] public function execute( note:GetContacts ):void
		{
			service.getContacts( new AsyncCallback( 
				function( contacts:Array ):void
				{
					bus.trigger( new GotContacts( contacts ) );			
				})
			);
		}
	}
}