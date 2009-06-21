package com.example
{
	public class Speaker implements ISpeaker
	{
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
			
		}
	}
}