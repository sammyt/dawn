package com.example.notifications
{
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import uk.co.ziazoo.notifier.AsyncCallback;

	public class ResponderCallback extends AsyncCallback implements IResponder
	{
		public function ResponderCallback( callback:Function=null )
		{
			super( callback );
		}
		
		public function result( data:Object ):void
		{
			if( data is ResultEvent )
			{
				onResult( data.result );
			}
			else
			{
				onResult( data );
			}
		}
		
		public function fault( info:Object ):void
		{
			
		}
	}
}