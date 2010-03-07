package uk.co.ziazoo.injector.impl
{
  internal class InstanceCreator
  {
    
    internal static function create( type:Class, params:Array ):Object
    {
      if( !params )
      {
        return new type();
      }
      
      switch ( params.length ) {
        case 0:
          return new type();
        case 1:
          return new type(params[0]);
        case 2:
          return new type(params[0], params[1]);
        case 3:
          return new type(params[0], params[1], params[2]);
        case 4:
          return new type(params[0], params[1], params[2], params[3]);
        case 5:
          return new type(params[0], params[1], params[2], params[3], params[4]);
        case 6:
          return new type(params[0], params[1], params[2], params[3], params[4], params[5]);
        case 7:
          return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
        case 8:
          return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
        case 9:
          return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
        case 10:
          return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
      }
      return null;
    }
  }
}