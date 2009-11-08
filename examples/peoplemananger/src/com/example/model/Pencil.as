package com.example.model
{
	public class Pencil implements IPencil
	{
		private var _message:String;
		
		public function Pencil( message:String )
		{
			_message = message;
		}
		
		public function get scribble():String
		{
			return _message;
		}
	}
}