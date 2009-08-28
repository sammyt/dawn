package
{
	import uk.co.ziazoo.notifier.INotificationBus;

	public class GetPersonListCommand
	{
		[Inject]
		public var bus:INotificationBus;
		
		public function GetPersonListCommand()
		{
		}
		
		[Execute]
		public function execute( notification:GetPersonList ):void
		{
			notification.onResult( [ "sam", "becky", bus ] );
		}
	}
}	