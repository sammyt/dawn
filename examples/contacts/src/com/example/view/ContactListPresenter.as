package com.example.view
{
	import com.example.model.GotContacts;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	
	import uk.co.ziazoo.notifier.IListenerRegistration;
	import uk.co.ziazoo.notifier.INotificationBus;

	public class ContactListPresenter implements IPresenter
	{
		/**
		 * Used to send and recieve notifications
		 */ 
		private var _bus:INotificationBus;
		
		/**
		 * Any listeners added to the notification bus
		 */ 
		private var _listeners:Vector.<IListenerRegistration>;
		
		/**
		 * The view this presented manages
		 */ 
		private var _view:ContactListView;
		
		public function ContactListPresenter()
		{
		}
		
		[DependenciesInjected]
		/**
		 * Add any listeners to the notification bus
		 * once all the dependencies are injected
		 */ 
		public function setup():void
		{
			_listeners = new Vector.<IListenerRegistration>(
				_bus.addCallback( GotContacts, function( note:GotContacts ):void
				{
					_view.contacts = new ArrayCollection( note.contacts );
				})
			);
		}
		
		/**
		 * Call when you want to destroy the object, this will
		 * clean up any listeners added to the notification bus
		 */ 
		public function tearDown():void
		{
			for each( var listener:IListenerRegistration in _listeners )
			{
				listener.remove();
			}
		}
		
		[Inject]
		public function set bus( value:INotificationBus ):void
		{
			_bus = value;
		}
		
		[Inject]
		public function set view( value:ContactListView ):void
		{
			_view = value;
		}
		
		public function get displayObject():DisplayObject
		{
			return _view;
		}
	}
}