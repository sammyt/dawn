package com.example.commands
{
	import com.example.view.PersonDetailsPresenter;
	import com.example.view.PersonListPresenter;
	
	import uk.co.ziazoo.INotificationBus;

	public class SetupViewCommand implements ICommand
	{
		private var _personDetailsPresenter:PersonDetailsPresenter;
		private var _personListPresenter:PersonListPresenter;
		private var _bus:INotificationBus;
		
		public function SetupViewCommand()
		{
		}
		
		[Inject]
		public function set personDetailsPresenter( value:PersonDetailsPresenter ):void
		{
			_personDetailsPresenter = value;
		}
		
		[Inject]
		public function set personListPresenter( value:PersonListPresenter ):void
		{
			_personListPresenter = value;
		}

		[Inject]
		public function set notificationBus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		public function execute():void
		{
			_bus.addHandler( _personDetailsPresenter );
			_bus.addHandler( _personListPresenter );
		}
	}
}