package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import org.as3.serializer.Serializer;
	import org.as3.serializer.example.ValueObjectCollectionExample;

	public class SerializeDeserializerTester
	{		
		[Test]
		public function testVoCollection():void
		{
			Assert.assertNotNull( ValueObjectCollectionExample.valueObjectCollection );
		}
		
		[Test]
		public function testSerializeVoCollectionToXML():void
		{
			Assert.assertNotNull( Serializer.serialize( ValueObjectCollectionExample.valueObjectCollection ) );
		}
		
		[Test]
		public function testDeserializeXMLIntoVoCollection():void
		{
			var xml:XML =  Serializer.serialize( ValueObjectCollectionExample.valueObjectCollection );
			Assert.assertNotNull( Serializer.deserialize( xml) );
		}
	}  
}