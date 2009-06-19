package com.example.app
{
	public class Contact
	{
		public var id:int;
		public var name:String;
		
		public function Contact()
		{
		}
		
		public function toString():String
		{
			return "[Contact id:" + id + ", name:" + name + "]";
		}
	}
}