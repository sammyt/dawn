package uk.co.ziazoo.injector.impl
{
  import flash.utils.Dictionary;

  import uk.co.ziazoo.fussy.model.Method;
  import uk.co.ziazoo.fussy.query.IQuery;
  import uk.co.ziazoo.fussy.query.ITypeQuery;
  import uk.co.ziazoo.fussy.query.Query;
  import uk.co.ziazoo.injector.ITypeInjectionDetails;
  import uk.co.ziazoo.injector.ITypeInjectionDetailsFactory;

  /**
   * Uses the Fussy query language to create ITypeInjectionDetails objects
   * based on metadata on the classes
   */
  public class FussyTypeDetailsFactory implements ITypeInjectionDetailsFactory
  {
    private var cache:Dictionary;
    private var query:Query;
    private var methodsQuery:IQuery;
    private var propertiesQuery:IQuery;
    private var postConstructQuery:IQuery;
    private var providerQuery:IQuery;
    private var typeQuery:ITypeQuery;

    /**
     * Create instance of FussyTypeDetailsFactory
     * @param query created by fussy used to query types
     */
    public function FussyTypeDetailsFactory(query:Query)
    {
      this.query = query;

      typeQuery = query.getTypeQuery();
      methodsQuery = query.findMethods().withMetadata("Inject").withArguments();
      propertiesQuery = query.findProperties().withMetadata("Inject");
      postConstructQuery = query.findMethods().withMetadata("PostConstruct").noCompulsoryArguments();
      providerQuery = query.findMethods().withMetadata("Provider").noCompulsoryArguments();

      cache = new Dictionary();
    }

    /**
     * @inheritDoc
     */
    public function forType(type:Class):ITypeInjectionDetails
    {
      var details:ITypeInjectionDetails = cache[type] as ITypeInjectionDetails;

      if (details)
      {
        return details;
      }

      details = new TypeInjectionDetails(
        propertiesQuery.forType(type),
        methodsQuery.forType(type),
        typeQuery.forType(type).constructor,
        distinctMethod(type, postConstructQuery),
        distinctMethod(type, providerQuery),
        typeQuery.forType(type).metadata
        );

      cache[type] = details;
      return details;
    }

    private function distinctMethod(type:Class, query:IQuery):Method
    {
      var result:Array = query.forType(type);
      if (result.length == 1)
      {
        return Method(result[0]);
      }
      return null;
    }
  }
}