package org.as3.serializer
{
	import flash.utils.getQualifiedClassName;
	
	import org.as3.serializer.enums.SerializerEnums;
	import org.as3.serializer.utils.GetObjectType;
	import org.as3.serializer.utils.SerializerNamespaces;
	import org.as3.serializer.utils.GetTypedObject;

	/**
	 * 
	 * Deserialize serializer XML to value objects
	 * 
	 * @author Mario
	 *  
	 */	
	public final class XMLToValueObject
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */				
		public function XMLToValueObject(){}
		
		/**
		 *
		 * Returns a typed object of the Serializer <code>xml</code> 
		 * @param xml Serialized object xml
		 * @return Typed object with assigned properties
		 * 
		 */		
		public static function deserializeXMLIntoObject(xml:XML, findClassPackage:String = null, replaceClassPackage:String = null):*
		{
			SerializerNamespaces.checkNamespace(xml);
			var objectClass:*	= GetTypedObject.getDataTypedObject( getType(xml[0].children()[0].@type, findClassPackage, replaceClassPackage) );
			return 	objectClass = getSerializedObjectFromXML(xml[0].children()[0].children(), objectClass, findClassPackage, replaceClassPackage);
		}
		
		
		/**
		 * 
		 * @private
		 * 
		 */		
		protected static function getSerializedObjectFromXML(xmlChildren:XMLList, objectClass:*, findType:String = null, replaceType:String = null):*
		{
			for(var i:int = 0; i < xmlChildren.length(); i++)
			{
				var propType:String  = getType(xmlChildren[i].@type, findType, replaceType);
				var objectProperty:* ;
															   
				var isTopLevelIgnoringIterativeItems:Boolean = GetObjectType.isTopLevelObjectTypeIgnoringIterativeItems(propType);
				var isIterativeType:Boolean 				 = GetObjectType.isIterativeType(propType);
				
				if(isTopLevelIgnoringIterativeItems || !isIterativeType) objectProperty = GetTypedObject.getDataTypedObject(propType, ((isTopLevelIgnoringIterativeItems) ? xmlChildren[i].toString() : null), xmlChildren[i].name());
				if(isIterativeType) 						objectProperty = populateIterativeObject(xmlChildren[i].children(), GetTypedObject.getDataTypedObject(propType), findType, replaceType);	
				else if(!isTopLevelIgnoringIterativeItems)  objectClass[xmlChildren[i].name()] = getSerializedObjectFromXML(xmlChildren[i].children(), objectProperty, findType, replaceType);
				
				try{ objectClass[xmlChildren[i].name()] = objectProperty }
				catch(er:Error){ trace( getQualifiedClassName(XMLToValueObject) + 'not able to set object property ('+xmlChildren[i].name()+' of type: ' + propType+') - error: '+er) };
			}
			
			return objectClass;
		}
		
 
		
		/**
		 * 
		 * @private
		 * 
		 */
		protected static function populateIterativeObject(xmlChildren:XMLList, iterativeObject:*, findType:String = null, replaceType:String = null):*
		{
			for(var i:int; i < xmlChildren.length(); i++)
			{
				var objectClass:*	= GetTypedObject.getDataTypedObject( getType(xmlChildren[i].@type, findType, replaceType) );
				objectClass 		= getSerializedObjectFromXML(xmlChildren[i].children(), objectClass, findType, replaceType);
				
				if(iterativeObject.hasOwnProperty(SerializerEnums.ADD_ITEM)) iterativeObject.addItem(objectClass);
				else 														 iterativeObject.push(objectClass);
			}  
			
			return iterativeObject;
		}
		
		protected static function getType(type:String, findType:String = null, replaceType:String = null):String
		{
			return (!findType) ? type : String(type).replace(findType, replaceType);
		}
	}
}