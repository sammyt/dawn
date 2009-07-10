package com.example.model
{
	import uk.co.ziazoo.notifier.INotificationBus;

	public class PencilGenerator
	{
		public function PencilGenerator()
		{
		}
		
		[Provider]
		public function getPensil():IPencil
		{
			return new Pencil( "I'm a pencil scribble" );
		}
		/*
		[Inject(name="MyBus")]
		public function set bus( value:INotificationBus ):void
		{
			trace("PensilGenerator.bus", value);
		}
		*/
	}
} 