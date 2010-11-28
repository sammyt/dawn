package uk.co.ziazoo.notifier
{
  /**
   *  The <code>INotifier</code> allows you to send and receive
   *  notifications across your application.
   */
  public interface INotifier
  {
    /**
     * Sends a notification.  Any listeners registered to the type of this
     * payload will be triggered
     * @param payload the object that will be received by listeners
     */
    function trigger(payload:Object):void;

    /**
     * Adds a listeners to this INotifier instance.  Listeners are invoked
     * by notifications being triggered on this INotifier.  Listeners can choose
     * to use the polymorphic nature of actionscripts type system when
     * subscribing as a listener (false by default).
     *
     * @see INotifier#trigger
     *
     * @param type the actionscript type that will trigger (invoke) the
     * supplied callback (closure)
     * @param callback the function to invoke when a notification with the
     * supplied type is triggered.  The callback must have one (mandatory)
     * argument that if of the same type as that being listened for.  The
     * payload (notification) will be passed in through that first argument
     * @param polymorphic whether or not the INotifier should use the
     * polymorphic nature of the type system to trigger this listener.
     *
     * e.g. a listener added like this
     * <code>listen(GetSomethingFromServer, getSomethingFromServer);</code>
     *  will only be triggered by GetSomethingFromServer notifications, not its
     * subclasses.
     * <code>listen(GetSomethingFromServer, getSomethingFromServer, true);</code>
     * would be triggered by any class that passed the <code>is</code> operator.
     * So any subclass of GetSomethingFromServer.
     *
     * Using this polymorphic nature allows you to listen for interfaces
     * <code>listen(IServerRequest, onAnyServerRequest, true)</code>
     *
     * @return the callback that was passed in, this allows you to define
     * anonymous callbacks inline and store them for later removal
     */
    function listen(type:Class, callback:Function,
      polymorphic:Boolean = false):Function;

    /**
     * Remove a listener form the INotifier
     * @param type that the listener is registered against
     * @param callback the Function that was supplied to INotifier#listen
     */
    function remove(type:Class, callback:Function):void;
  }
}