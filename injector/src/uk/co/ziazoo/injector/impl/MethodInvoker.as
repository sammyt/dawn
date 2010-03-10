package uk.co.ziazoo.injector.impl
{
  public class MethodInvoker
  {
    private var instance:Object;
    private var methodName:String;
    
    public function MethodInvoker( instance:Object, methodName:String )
    {
      this.instance = instance;
      this.methodName = methodName;
    }
    
    public function invoke():void
    {
      var fnt:Function = instance[ methodName ] as Function;
      fnt.apply( instance );
    }
  }
}