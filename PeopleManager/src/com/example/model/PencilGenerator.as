package com.example.model
{
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
	}
}