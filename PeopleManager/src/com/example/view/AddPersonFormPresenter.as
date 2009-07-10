package com.example.view
{
	import com.example.model.Person;
	import com.example.notifications.AddPersonRequest;
	
	import flash.events.Event;
	
	import uk.co.ziazoo.notifier.INotificationBus;

	public class AddPersonFormPresenter
	{
		[Inject]
		public var bus:INotificationBus;
		
		public var _form:AddPersonForm; 
		
		public function AddPersonFormPresenter()
		{
		}
		
		[Inject]
		public function set form( value:AddPersonForm ):void
		{
			_form = value;
			_form.addEventListener( "addPerson", onAddPersonSumbit );
		}
		
		private function onAddPersonSumbit( event:Event ):void
		{
			var person:Person = new Person( _form.nameTxt.text, 
					parseFloat( _form.ageTxt.text ) );
			
			bus.trigger( new AddPersonRequest( person ) );
			
			_form.clear();
		}
	}
}