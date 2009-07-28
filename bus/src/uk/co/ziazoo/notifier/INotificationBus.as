package uk.co.ziazoo.notifier
{
	/**
	 * <p>The <code>INotificationBus</code> enables you to trigger a handler
	 * method on any object that subscribes to that bus by means of a notification.</p>
	 * 
	 * <p>The contract between a notification and a handler is specified by an interface, which
	 * the handler must implement and the notification will accept as an argument
	 * to a method it can specify with the <code>[InjectHandler]</code> metadata<p>
	 * 
	 * <p>Suppose we have a scenario within an application where we want several
	 * unrelated parts of the application to respond to or be informed of an event
	 * <code>Person</code> object has been saved.  <br/>We would begin by defining
	 * an interface that describes the handling of that event</p>
	 * 
	 * <listing version="3.0">
	 * public interface IHandlePersonSaved
	 * {
	 * 	function onPersonSaved( savedPerson:Person ):void;
	 * }
	 * </listing>
	 * 
	 * <p>Next we need a notification that encapsulates the action, and defines
	 * a handler method which will process each of the handlers in turn</p>
	 * 
	 * <listing version="3.0">
	 * public class PersonSaved
	 * {
	 * 	private var _savedPerson:Person;
	 * 	public function PersonSaved( savedPerson:Person )
	 * 	{
	 * 		_savedPerson = savedPerson;
	 * 	}
	 * 	
	 * 	[InjectHandler]
	 * 	public function nextHandler( handler:IHandlePersonSaved ):void
	 * 	{
	 * 		handler.onPersonSaved( _savedPerson );
	 * 	}
	 * }
	 * </listing>
	 * 
	 * <p>There are a couple of key things to note about the notification class, firstly there
	 * is a method annotated with <code>[InjectHandler]</code> metadata which takes an 
	 * <code>IHandlePersonSaved</code> object as an argument and secondly we see that 
	 * it does not implement any interface.</p>
	 * 
	 * <p>The first point tells us everything we need to know to understand this notification
	 * (though the name should be self explanatory), it receives handlers of type
	 * <code>IHandlePersonSaved</code> via the <code>nextHandler</code> method (though the 
	 * name of the method could have been anything) since this is the annotated method, and it calls
	 * the handlers <code>onPersonSaved</code> method with the saved person as the argument.  The second
	 * point is important as it enables us to use any object at all as a notification, so long as it
	 * has a single method with the <code>[InjectHandler]</code> metadata which takes one argement
	 * with the type it requires the handlers conform to.</p>
	 * 
	 * <p>That is all the setup work required! There are no strings defining types, 
	 * or mapping of notifications to handlers, all that is needed is a notification
	 * which knows what type it wants.  Passing an instance of <code>PersonSaved</code> to the trigger
	 * method will now cause the <code>onPersonSaved</code> method to be called on any handlers
	 * which implement <code>IHandlePersonSaved</code> and are subscribed to the notification bus.</p>
	 */ 
	public interface INotificationBus
	{
		/**
		 * trigger is used to send notifications out into the system.
		 * A notification can be any object with a [InjectHander] method
		 */ 
		function trigger( notification:Object ):void;
		
		/**
		 * Adds a hander to the bus.  handlers can be of any type
		 * and need not implment any interfaces.  Though the notifications
		 * that they will want to be triggered by will likely require they implement
		 * something.
		 */ 
		function addHandler( handler:Object ):void;
		
		/**
		 * Remove an handler, after removal no notifications will trigger
		 * handler methods on the supplied object
		 */ 
		function removeHandler( handler:Object ):void;
		
		/**
		 * Sometimes it would not be appropriate to implement the interface
		 * a notification requires of a handler, but you may still want an object to be aware of
		 * its occurance. In this scenario you can add callbacks which will be called
		 * when a notification is triggered
		 */ 
		function addCallback( notificationType:Class, callback:Function ):void;
		
		/**
		 * removes a callback from the bus
		 */ 
		function removeCallback( notificationType:Class, callback:Function ):void;
	}
}