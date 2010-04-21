package com.example.view
{
  import com.example.model.CreateContact;

  import flash.display.DisplayObject;
  import flash.events.Event;

  public class CreateContactPresenter implements IPresenter
	{
		private var _view:CreateContactView;
		private var _listeners:Vector.<IListenerRegistration>;
		private var _bus:INotificationBus;
		
		public function CreateContactPresenter( view:CreateContactView, bus:INotificationBus )
		{
      _view = view;
      _bus = bus;
		}
		
		[DependenciesInjected]
		/**
		 * Adds any necessary listeners to the view
		 */ 
		public function setup():void
		{
			_view.addEventListener( "addContact", onSubmit );
		}
		
		/**
		 * removes any listeners from the view
		 */  	
		public function tearDown():void
		{
			_view.removeEventListener( "addContact", onSubmit );
		}
		
		private function onSubmit( event:Event ):void
		{
			if( _view.newContact.name != "" )
			{
				_bus.trigger( new CreateContact( _view.newContact ) );
				_view.nameInput.text = "";
			}
		}
		
		public function get displayObject():DisplayObject
		{
			return _view;
		}
	}
}