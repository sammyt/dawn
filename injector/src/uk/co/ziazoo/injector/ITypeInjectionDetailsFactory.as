package uk.co.ziazoo.injector
{
  /**
   * Creates instances of <code>ITypeInjectionDetails</code>
   */
  public interface ITypeInjectionDetailsFactory
  {
    /**
     * Creates an instance of <code>ITypeInjectionDetails</code> for a type
     * @param type who's ITypeInjectionDetails are needed
     * @return the details object
     */
    function forType(type:Class):ITypeInjectionDetails;
  }
}