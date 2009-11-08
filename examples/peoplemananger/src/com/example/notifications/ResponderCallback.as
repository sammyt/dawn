package com.example.notifications
{
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	
	import uk.co.ziazoo.notifier.AsyncCallback;

	/**
	*	Simple extension of the <code>AsyncCallback</code> class to make
	*	it implement the <code>IResponder</code> interface
	*/	
	public class ResponderCallback extends AsyncCallback implements IResponder
	{
		public function ResponderCallback( result:Function )
		{
			super( result );
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