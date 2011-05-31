package org.as3.serializer
{
	import flash.events.EventDispatcher;
	
	import org.as3.serializer.enums.SerializerEnums;
	import org.as3.serializer.utils.GetObjectType;
	import org.as3.serializer.utils.ObjectDescriptor;
	import org.as3.serializer.utils.SerializerNamespaces;
	import org.as3.serializer.utils.ValueToString;
	import org.as3.serializer.persister.enums.PersisterEnums;
	
	/**
	 * Serializes value objects into XML (Serializer XML namespace)
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public final class ValueObjectToXML extends EventDispatcher	
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
				var propName:String  						  = serializerElements[i].@name;
				var propType:String							  = serializerElements[i].@type;
				var isTopLevelIgnoringIterativeItems:Boolean  = GetObjectType.isTopLevelObjectTypeIgnoringIterativeItems(propType);
				var isIterativeType:Boolean					  = GetObjectType.isIterativeType(propType);
				
				//find base value if possible
				var propValue:String = (isTopLevelIgnoringIterativeItems) ? ValueToString.toString(object[propName]) : null;
				var node:XML 		 = getNode(propName, propValue, propType);
				
				if (!isTopLevelIgnoringIterativeItems && !isIterativeType) getObjectXML(object[propName], node);
				
				if(!object[propName] || !isIterativeType) element.appendChild( node );
				else element.appendChild( getCollectionNode(object[propName], node) );
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
				var collectionNode:XML 	= getNode( ObjectDescriptor.getClassConstructor(iterativeObject[i]), null, ObjectDescriptor.getObjectType(iterativeObject[i]));
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