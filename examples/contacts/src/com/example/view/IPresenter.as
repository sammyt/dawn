package com.example.view
{
	import flash.display.DisplayObject;

	public interface IPresenter
	{
		function get displayObject():DisplayObject;
		function setup():void;
		function tearDown():void;
	}
}