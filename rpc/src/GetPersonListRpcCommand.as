package
{
	import uk.co.ziazoo.rpc.ICommand;
	import uk.co.ziazoo.rpc.IRpcNotification;

	public class GetPersonListRpcCommand implements ICommand
	{
		public function GetPersonListRpcCommand()
		{
		}
		
		[Execute]
		public function execute( notification:GetPersonList ):void
		{
			notification.onResult( [ "sam", "becky" ] );
		}
	}
}