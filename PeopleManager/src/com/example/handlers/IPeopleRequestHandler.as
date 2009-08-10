package com.example.handlers
{
	import mx.rpc.IResponder;

	public interface IPeopleRequestHandler
	{
		function retrieveAllPeople( responder:IResponder = null ):void;
	}
}