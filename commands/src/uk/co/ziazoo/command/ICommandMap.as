package uk.co.ziazoo.command
{
  /**
   * defines API for adding command classes to Dawn
   */
  public interface ICommandMap
  {
    /**
     * Adds a command class (a class that has a method decorated with
     * the Execute metadata) to Dawn
     *
     * @param command the class (type) of the command
     * @param polymorphic if true any notifications that <code>is</code> of type
     * command will trigger this command.
     * @see uk.co.ziazoo.notifier.INotifier#listen
     */
    function add(command:Class, polymorphic:Boolean = false):void;
  }
}