package uk.co.ziazoo.command
{
  import uk.co.ziazoo.injector.IInjector;
  import uk.co.ziazoo.notifier.INotifier;
  
  /**
   * Implements ICommandMap allowing users to register commands with
   * Dawn.
   */ 
  public class CommandMap implements ICommandMap
  {
    private var notifier:INotifier;
    private var injector:IInjector;
    
    public function CommandMap(injector:IInjector, notifier:INotifier)
    {
      this.injector = injector;
      this.notifier = notifier;
    }
    
    /**
     * @private
     * 
     * the function that is invoked by the notification callback.
     * 
     * @param command:Command the command details of the command to invoke 
     * @param notification:Object the trigger notification
     */ 
    internal function invokeCommand(command:Command, notification:Object):void
    {
      var instance:Object = injector.inject( command.commandType );
      command.invoke( instance, notification );
    }
    
    /**
     * @inheritDoc
     */ 
    public function add(command:Class, polymorphic:Boolean = false):void
    {
      var details:Command = new Command( command );
      
      notifier.listen( details.triggerType, 
        function( note:Object ):void
        {
          invokeCommand( details, note );
        }, polymorphic);
    }
  }
}