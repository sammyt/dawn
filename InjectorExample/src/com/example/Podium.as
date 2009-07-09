package com.example
{
	public class Podium
	{
		private var _speaker:ISpeaker;
		private var _megaphone:Megaphone;
		
		public function Podium()
		{
			
		}
		
		public function talk( message:String ):void
		{
			speaker.speak( message );
		}
		
		[Inject]
		public function set speaker( speaker:ISpeaker ):void
		{
			_speaker = speaker;
		}
		
		public function get speaker():ISpeaker
		{
			return _speaker;
		}
		
		[Inject]
		public function set megaphone( value:Megaphone ):void
		{
			_megaphone = value;
		}
		
		public function get megaphone():Megaphone
		{
			return _megaphone;
		}
	}
}