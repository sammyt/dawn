package com.example.notifications
{
	import com.example.handlers.IBaseFailureHandler;

	public class BaseFailureWorker
	{
		public function BaseFailureWorker()
		{
		}
		
		[InjectHandler]
		public function nextHandler( handler:IBaseFailureHandler ):void
		{
			handler.onFail();
		}
	}
}