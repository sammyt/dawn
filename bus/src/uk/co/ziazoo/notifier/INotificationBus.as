package uk.co.ziazoo.notifier
{
	public interface INotificationBus
	{
		function trigger( worker:Object ):void;
		
		function addHandler( handler:Object ):void;
		
		function removeHandler( handler:Object ):void;
	}
}