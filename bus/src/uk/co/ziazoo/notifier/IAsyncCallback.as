package uk.co.ziazoo.notifier
{
	public interface IAsyncCallback
	{
		function onResult( ...args ):void;
		
		function onFault( ...args ):void;
	}
}