package uk.co.ziazoo.command
{
  import flash.utils.describeType;
  import flash.utils.getDefinitionByName;
  
  /**
   * internal representation of a command.
   */ 
  internal class Command
  {
    /**
     * the output of describeType on the command
     */ 
    private var _reflection:XML;
    
    /**
     * The class object of the users command
     */
    private var _commandType:Class;
    
    /**
     * the type of notification that would trigger this command
     */ 
    private var _triggerType:Class;
    
    /**
     * the name of the Execute method
     */  
    private var _methodName:String;
    
    /**
     * Create a <code>Command</code> from a class which contains
     * a method with the Execute metadata
     */ 
    public function Command( commandType:Class )
    {
      _commandType = commandType;
    }
    
    /**
     * returns a snipit of xml for the method with teh Execute metadata
     */ 
    internal function findExecuteMethod( type:Class ):XML
    {
      if( ! _reflection )
      {
        var reflection:XML = describeType( type );
        var executes:XMLList = reflection.factory..metadata.(@name == "Execute");
        _reflection = executes.parent();
      }
      return _reflection;
    }
    
    /**
     * @private 
     * 
     * get the name of the method with the execute metadata
     */ 
    internal function getMethodName():String 
    {
      if( ! _methodName )
      {
        _methodName = findExecuteMethod( _commandType ).@name;
      }
      return _methodName;
    }
    
    /**
     * call the execute method of the command
     * 
     * @param command:Object the instance of commandType
     * @param notification:Object the notification that has triggered this
     * call to invoke
     */ 
    public function invoke( command:Object, notification:Object ):void
    {
      var execute:Function = command[ getMethodName() ] as Function;
      execute.apply( command, [ notification ] );
    }
    
    /**
     * the type of the command
     */ 
    public function get commandType():Class
    {
      return _commandType;
    }
    
    /**
     * the type of the notification that would trigger this command
     */ 
    public function get triggerType():Class
    {
      if( ! _triggerType )
      {
        _triggerType = getDefinitionByName( findExecuteMethod( 
          _commandType ).parameter.@type ) as Class; 
      }
      return _triggerType;
    }
  }
}