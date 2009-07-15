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
	}
} 