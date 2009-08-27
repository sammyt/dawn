package
{
	import uk.co.ziazoo.notifier.INotificationBus;
	import uk.co.ziazoo.rpc.ICommand;

	public class GetPersonListRpcCommand implements ICommand
	{
		[Inject]
		public var bus:INotificationBus;
		
		public function GetPersonListRpcCommand()
		{
		}
		
		[Execute]
		public function execute( notification:GetPersonList ):void
		{
			notification.onResult( [ "sam", "becky", bus ] );
		}
	}
}