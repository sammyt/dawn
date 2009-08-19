package uk.co.ziazoo.notifier
{
	public class AsyncCallback implements IAsyncCallback
	{
		protected var _result:Function;
		protected var _fault:Function;
		
		public function AsyncCallback( result:Function = null, fault:Function = null )
		{
			_result = result;
			_fault = fault;
		}
		
		public function onResult( ...args ):void
		{
			if( _result != null )
			{
				_result.apply( this, args );
			}
		}
		
		public function onFault( ...args ):void
		{
			if( _fault != null )
			{
				_fault.apply( this, args );
			}
		}
	}
}