package flexUnitTests
{
	import org.as3.serializer.example.ValueObjectCollectionExample;
	import org.as3.serializer.Serializer;

	public class SerializeDeserializerTester
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testVoCollection():void
		{
			//Assert.assertNotNull( ValueObjectCollectionExample.valueObjectCollection );
		}
		
		[Test]
		public function testSerializeVoCollectionToXML():void
		{
			//Assert.assertNotNull( Serializer.serializeValueObjectIntoXML( ValueObjectCollectionExample.valueObjectCollection ) );
		}
		
		[Test]
		public function testDeserializeXMLIntoVoCollection():void
		{
			var xml:XML =  Serializer.serialize( ValueObjectCollectionExample.valueObjectCollection );
			//Assert.assertNotNull( Serializer.deserializeXMLIntoValuObject(xml) );
		}
	}
}