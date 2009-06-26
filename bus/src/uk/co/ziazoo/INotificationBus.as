package uk.co.ziazoo
{
	public interface INotificationBus
	{
		function map( worker:Class, handler:Class ):void;
		
		function trigger( worker:Object ):void;
		
		function addHandler( handler:Object ):void;
	}
}