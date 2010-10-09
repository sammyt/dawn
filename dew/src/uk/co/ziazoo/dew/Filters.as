/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 09/10/2010
 * Time: 15:05
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.dew
{
  import uk.co.ziazoo.notifier.INotifier;
  import uk.co.ziazoo.notifier.Notifier;

  public class Filters
  {
    private var conditionCheck:INotifier;
    private var typeCheck:INotifier;

    private var typeIsFiltered:Boolean = false;
    private var passes:Boolean = false;

    public function Filters()
    {
      conditionCheck = new Notifier();
      typeCheck = new Notifier();
    }

    public function add(type:Class, condition:Function, polymorphic:Boolean = false):void
    {
      conditionCheck.listen(type, function(message:Object):void
      {
        passes = condition.apply(null, [ message ]) || false;
      }, polymorphic);

      typeCheck.listen(type, function(message:Object):void
      {
        typeIsFiltered = true;
      }, polymorphic);
    }

    public function isTypeFiltered(message:Object):Boolean
    {
      typeIsFiltered = false;

      typeCheck.trigger(message);

      return typeIsFiltered;
    }

    public function doesMessagePassFilters(message:Object):Boolean
    {
      passes = false;

      conditionCheck.trigger(message);

      return passes;
    }
  }
}
