package com.example.model
{
	import uk.co.ziazoo.INotificationBus;

	public class PencilGenerator
	{
		public function PencilGenerator()
		{
		}
		
		[Provider]
		public function getPensil():Pencil
		{
			return new Pencil( "yo yo yo" );
		}
		
		[Inject]
		public function set bus( value:INotificationBus ):void
		{
			trace("PensilGenerator.bus", value);
		}
	}
} 