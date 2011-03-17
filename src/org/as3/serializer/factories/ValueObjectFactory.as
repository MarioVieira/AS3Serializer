package org.as3.serializer.factories
{
	import flash.utils.getQualifiedClassName;
	
	import org.as3.serializer.enums.SerializerEnums;
	import org.as3.serializer.helpers.GetObjectType;
	import org.as3.serializer.helpers.SerializerNamespaces;

	/**
	 * 
	 * @author Mario
	 * It factors objects of the type described by the xml serializer type 
	 */	
	public final class ValueObjectFactory
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */				
		public function ValueObjectFactory(){}
		
		/**
		 *
		 * Returns a typed object of the Serializer <code>xml</code> 
		 * @param xml Serialized object xml
		 * @return Typed object with assigned properties
		 * 
		 */		
		public static function deserializeXMLIntoObject(xml:XML):*
		{
			SerializerNamespaces.checkNamespace(xml);
			var objectClass:*	= ObjectFactory.getDataTypedObject( xml[0].children()[0].@type );
			return 	objectClass = getSerializedObjectFromXML(xml[0].children()[0].children(), objectClass);
		}
		
		/**
		 * 
		 * @private
		 * 
		 */		
		protected static function getSerializedObjectFromXML(xmlChildren:XMLList, objectClass:*, recursivePropertyName:String = null):*
		{
			for(var i:int = 0; i < xmlChildren.length(); i++)
			{
				var propType:String  = xmlChildren[i].@type;
				var objectProperty:* ;
															   
				var isTopLevelIgnoringIterativeItems:Boolean = GetObjectType.isTopLevelObjectTypeIgnoringIterativeItems(propType);
				var isIterativeType:Boolean 				 = GetObjectType.isIterativeType(propType);
				
				if(isTopLevelIgnoringIterativeItems || !isIterativeType) objectProperty = ObjectFactory.getDataTypedObject(propType, ((isTopLevelIgnoringIterativeItems) ? xmlChildren[i].toString() : null), xmlChildren[i].name());
				if(isIterativeType) 						objectProperty = populateIterativeObject(xmlChildren[i].children(), ObjectFactory.getDataTypedObject(propType));	
				else if(!isTopLevelIgnoringIterativeItems)  objectClass[xmlChildren[i].name()] = getSerializedObjectFromXML(xmlChildren[i].children(), objectProperty);
				
				try{ objectClass[xmlChildren[i].name()] = objectProperty }
				catch(er:Error){ trace( getQualifiedClassName(ValueObjectFactory) + 'not able to set object property ('+xmlChildren[i].name()+' of type: ' + propType+') - error: '+er) };
			}
			
			return objectClass;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */
		protected static function populateIterativeObject(xmlChildren:XMLList, iterativeObject:*):*
		{
			for(var i:int; i < xmlChildren.length(); i++)
			{
				var objectClass:*	= ObjectFactory.getDataTypedObject( xmlChildren[i].@type );
				objectClass 		= getSerializedObjectFromXML(xmlChildren[i].children(), objectClass);
				
				if(iterativeObject.hasOwnProperty(SerializerEnums.ADD_ITEM)) iterativeObject.addItem(objectClass);
				else 														 iterativeObject.push(objectClass);
			}
			
			return iterativeObject;
		}
	}
}