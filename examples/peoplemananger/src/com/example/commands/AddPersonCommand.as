package com.example.commands 
{
	import com.example.notifications.AddPerson;
	
	public class AddPersonCommand
	{
		[Inject]
		public var model:PersonModel;
		
		public function AddPersonCommand()
		{
		}
		
		[Execute]
		public function execute( note:AddPerson ):void
		{
			model.addPerson( note.person, note );
		}
	}
}

