package uk.co.ziazoo.injector.impl 
{
  import org.flexunit.*;
  import uk.co.ziazoo.injector.*;
  import some.thing.*;
  import flash.utils.describeType
    
    public class MapperTest
    {
      private var mapper:Mapper;
      
      public function MapperTest()
      {
      }
      
      [Before]
      public function setUp():void
      {
        mapper = new Mapper( null );
      }
      
      [After]
      public function tearDown():void
      {
        mapper = null;
      }
      
      [Test]
      public function outputXML():void
      {
        try{ new Tree(null); } catch( e:Error ) {};
        trace( describeType( Tree ) );
      }
      
      [Test]
      public function canMap():void
      {
        mapper.map( Car ).to( CarWithTwoRadios );
        var mapping:IMapping = mapper.getMapping( Car );
        Assert.assertTrue( "correct type for DSL", mapping.type == Car );
        Assert.assertTrue( "correct name for DSL", mapping.name == "" );
      }
      
      [Test]
      public function getsCorrectMapByName():void
      {
        mapper.map( Car ).to( CarWithTwoRadios );
        mapper.map( Car ).to( CarWithOneRadio ).named( "one" );
        var noName:IMapping = mapper.getMapping( Car );
        var named:IMapping = mapper.getMapping( Car, "one" );
        
        Assert.assertTrue( "correct type for DSL", noName.type == Car );
        Assert.assertTrue( "correct name for DSL", noName.name == "" );
        
        Assert.assertTrue( "correct type for DSL", named.type == Car );
        Assert.assertTrue( "correct name for DSL", named.name == "one" );
      }
      
      [Test]
      public function canGetEagers():void
      {
        var mapping:Mapping = new Mapping(Tree);
        mapper.addToEagerQueue(mapping);
        
        Assert.assertTrue("one item in queue", mapper.getEagerQueue().length == 1);
        Assert.assertTrue("queue cleared", mapper.getEagerQueue().length == 0);
      }
    }
}

