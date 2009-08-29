package com.example.model
{
	[Bindable]
	public class Person
	{
		public var name:String;
		public var age:int;
		
		public function Person( name:String, age:int )
		{
			this.name = name;
			this.age = age;
		}
	}
}