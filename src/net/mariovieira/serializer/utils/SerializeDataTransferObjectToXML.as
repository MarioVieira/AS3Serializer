package net.mariovieira.serializer.utils
{
	import net.mariovieira.serializer.enums.SerializerEnums;
	import net.mariovieira.serializer.helpers.GetIterativeTypes;
	import net.mariovieira.serializer.helpers.ObjectDescriptor;
	import net.mariovieira.serializer.helpers.PropertyValueToString;
	import net.mariovieira.serializer.helpers.SerializerNamespaces;
	import net.mariovieira.serializer.persister.enums.PersisterEnums;
	
	/**
	 * Serializes Value Objects into XML of Serializer namespace
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public final class SerializeDataTransferObjectToXML
	{
		/**
		 * Returns a Serializer xml of the provided object
		 *  
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getSerializerXMLFromObject(object:Object):XML
		{
			var element:XML = getNode( ObjectDescriptor.getClassConstructor(object),  null, ObjectDescriptor.getObjectType(object));
			return new XML(SerializerEnums.XML_VERSION + < {SerializerEnums.SERIALIZER} >{ getObjectXML(object, element) }</ {SerializerEnums.SERIALIZER} >).addNamespace( SerializerNamespaces.getSerializerNamespace() );
		}
		
		/**
		 * 
		 * @private
		 * 
		 */		
		protected static function getObjectXML(object:Object, element:XML):XML
		{
			var serializerElements:XMLList = ObjectDescriptor.getSerializerElements( object ).children();
		
			for(var i:int; i < serializerElements.length(); i++)
			{
				var propName:String  = serializerElements[i].@name;
				var propType:String  = ObjectDescriptor.classPackageAndNameOutOfQualifiedClassName(serializerElements[i].@type);
				var propValue:String = ( !GetIterativeTypes.isIterativeType(propType) ) ? PropertyValueToString.toString(object[propName]) : null;
				var node:XML 		 = getNode(propName, propValue, propType);
				
				element.appendChild( node );
				if( GetIterativeTypes.isIterativeType(propType) && object[propName]) element.appendChild( getCollectionNode(object[propName], node) );
			}
			
			return element;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */	
		protected static function getCollectionNode(iterativeObject:*, existingNode:XML):XML
		{
			
			for(var i:int; i < iterativeObject.length; i++) 
			{
				var collectionNode:XML 		= getNode( ObjectDescriptor.getClassConstructor(iterativeObject[i]), null, ObjectDescriptor.getObjectType(iterativeObject[i]));
				existingNode.appendChild( getObjectXML( iterativeObject[i], collectionNode) );
			}
			
			return existingNode;
		}
		
		
		/**
		 * 
		 * @private
		 * 
		 */	
		protected static function getNode(name:String, value:String, type:String):XML
		{
			return new XML( <{name} type={type}> {(value = (!value) ? "" : value)} </{name}> );
		}
	}
}