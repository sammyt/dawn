package com.example.view
{
	import com.example.model.CreateContact;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import uk.co.ziazoo.notifier.IListenerRegistration;
	import uk.co.ziazoo.notifier.INotificationBus;

	public class CreateContactPresenter implements IPresenter
	{
		private var _view:CreateContactView;
		private var _listeners:Vector.<IListenerRegistration>;
		private var _bus:INotificationBus;
		
		public function CreateContactPresenter()
		{
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
		
		[Inject]
		public function set view( value:CreateContactView ):void
		{
			_view = value;
		}
		
		[Inject]
		public function set bus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		public function get displayObject():DisplayObject
		{
			return _view;
		}
	}
}