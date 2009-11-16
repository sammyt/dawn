package com.example.model
{
	import mx.utils.UIDUtil;

	/**
	 * represents one contact in the application
	 */ 
	public class Contact
	{
		public var id:String;
		public var name:String;
		
		public function Contact( name:String )
		{
			this.name = name;
			this.id = UIDUtil.createUID();
		}
		
		public function toString():String
		{
			return name;
		}
	}
}