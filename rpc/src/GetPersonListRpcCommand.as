package
{
	import uk.co.ziazoo.notifier.INotificationBus;

	public class GetPersonListRpcCommand
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