package com.example.model
{
	import uk.co.ziazoo.notifier.INotificationBus;

	public class PencilGenerator
	{
		[Inject(name="scribble")] public var message:String;
		
		public function PencilGenerator()
		{
		}
		
		[Provider]
		public function getPensil():IPencil
		{
			return new Pencil( message );
		}
	}
} 