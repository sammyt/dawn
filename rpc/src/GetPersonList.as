package
{
	import uk.co.ziazoo.rpc.IRpcNotification;
	import uk.co.ziazoo.notifier.AsyncCallback;
	
	public class GetPersonList extends AsyncCallback implements IRpcNotification
	{
		public function GetPersonList( result:Function = null, fault:Function = null )
		{
			super( result, fault );
		}
	}
}