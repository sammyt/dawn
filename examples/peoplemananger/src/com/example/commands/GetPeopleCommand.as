package com.example.commands 
{
	import com.example.notifications.GetPeople;
	import com.example.model.PersonModel;
	
	public class GetPeopleCommand
	{
		[Inject]
		public var model:PersonModel;
		
		public function GetPeopleCommand()
		{
		}
		
		[Execute]
		public function execute( note:GetPeople ):void
		{
			model.retrieveAllPeople( note );
		}
	}
}

