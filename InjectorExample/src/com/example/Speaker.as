package com.example
{
	public class Speaker implements ISpeaker
	{
		private var _megaphone:Megaphone;
		
		public function Speaker()
		{
			
		}
		
		public function speak( message:String ):void
		{
			trace( message );
		}
		
		[Inject]
		public function set megaphone( value:Megaphone ):void
		{
			_megaphone = value;
		}
	}
}