package uk.co.ziazoo.notifier
{
	/**
	*	The <code>INotificationBus</code> allows you to send and receive 
	*	notifications accross your application.
	*	
	*	There are two ways of receiving notifications, either via a 
	*	registered callback function, or with a handler object.  The most common
	*	(and the simplest) approach is to add a callback with the <code>addCallback</code>
	*	method.  The second approach of adding a handler allows you to trigger functions on
	*	objects that have no knowledge of <code>INotificationBus</code>, but this is
	*	typically only useful if you want to invoke a method on some external code.
	*/	
	public interface INotificationBus
	{
		/**
		*	sends a notification out into the system, this triggering any 
		*	registered callback or handlers that respond to this typs of notification
		*	
		*	@param	notification	 The notification object to be send to the listeners
		*/	
		function trigger( notification:Object ):void;
		
		/**
		*	adds a callback which is to be triggered whenever a notification of type
		*	notificationType is triggered.
		*	
		*	@param	notificationType	 The type of notification which should
		*	trigger the callback.  This does not need to be a concrete class (e.g. MyNotification) it
		*	could be an interface such as IRpcNotification etc.
		*	
		*	@param	callback	 The function to be invoked when a notification of type
		*	notificationType is triggered
		*	
		*	@return		An instance of <code>IListenerRegistration</code> which can be used
		*	to remove this callback from the <code>INotificationBus</code>.  This can be very
		*	useful when adding anonymous functions as callbacks.
		*	
		*	@see	uk.co.ziazoo.notifier.IListenerRegistration|#remove Method used to 
		*	remove callbacks from the <code>INotificationBus</code>
		*/	
		function addCallback( notificationType:Class, callback:Function ):IListenerRegistration;
		
		/**
		*	removes a callback from the <code>INotificationBus</code>
		*	
		*	@param	notificationType	 The type the callback is registered against
		*	@param	callback	 The callback function you no longer want triggered
		*/	
		function removeCallback( notificationType:Class, callback:Function ):void;
		
		/**
		*	adds a handler to the <code>INotificationBus</code>
		*	
		*	@param	handler	 The handler object
		*	@return		An instance of <code>IListenerRegistration</code> which can be used
		*	to remove the handler from the <code>INotificationBus</code>
		*/	
		function addHandler( handler:Object ):IListenerRegistration;
		
		/**
		*	removes a handler from the <code>INotificationBus</code>
		*	
		*	@param	handler	 The handler to remove
		*/	
		function removeHandler( handler:Object ):void;
	}
}