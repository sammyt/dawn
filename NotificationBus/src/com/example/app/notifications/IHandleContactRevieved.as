package com.example.app.notifications
{
	import com.example.app.Contact;

	public interface IHandleContactRevieved
	{
		function onContact( contact:Contact ):void;
	}
}