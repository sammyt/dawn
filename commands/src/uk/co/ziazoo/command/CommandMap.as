package uk.co.ziazoo.command
{
  import flash.system.ApplicationDomain;
  import flash.utils.getDefinitionByName;

  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.fussy.model.Parameter;
  import uk.co.ziazoo.fussy.query.IQuery;
  import uk.co.ziazoo.fussy.query.IQueryBuilder;
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
    private var executeQuery:IQuery;
    private var applicationDomain:ApplicationDomain;
    
    public function CommandMap(injector:IInjector, notifier:INotifier,
      queryBuilder:IQueryBuilder, applicationDomain:ApplicationDomain = null)
    {
      this.injector = injector;
      this.notifier = notifier;
      this.executeQuery = queryBuilder
        .findMethods()
        .withMetadata("Execute")
        .withArgsLengthOf(1);
      this.applicationDomain = applicationDomain || ApplicationDomain.currentDomain;
    }

    /**
     * @private
     *
     * the function that is invoked by the notification callback.
     */
    internal function invokeCommand(method:Method, type:Class, notification:Object):void
    {
      var instance:Object = injector.inject(type);
      method.invoke(instance, [notification]);
    }

    /**
     * @inheritDoc
     */
    public function add(command:Class, polymorphic:Boolean = false):void
    {
      var result:Array = executeQuery.forType(command);

      if (result.length == 0)
      {
        throw new Error("No [Execute] metadata found");
      }

      if (result.length > 1)
      {
        throw new Error("Only one [Execute] metadata per class allowed");
      }

      var method:Method = result[0] as Method;

      if (method.parameters.length == 0)
      {
        throw new Error("No parameter found, [Execute] method must have " +
          "exactly one parameter as it is used to map the command");
      }

      if (method.parameters.length > 1)
      {
        throw new Error(method.parameters.length + " parameters found, " +
          "[Execute] method must have exactly one parameter");
      }

      var parameter:Parameter = method.parameters[0] as Parameter;

      var type:Class = Class(applicationDomain.getDefinition(parameter.type));
      notifier.listen(type,
        function(note:Object):void
        {
          invokeCommand(method, command, note);
        }, polymorphic);
    }

  }
}