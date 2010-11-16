package net.mariovieira.serializer.factories
{
	import net.mariovieira.serializer.enums.SerializerEnums;
	import net.mariovieira.serializer.helpers.GetIterativeTypes;
	import net.mariovieira.serializer.helpers.SerializerNamespaces;
	import net.mariovieira.serializer.interfaces.ICRUD;
	import net.mariovieira.serializer.persister.control.SerializerCRUD;

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
			var objectClass:*	= PropertyFactory.getDataTypedObject( xml[0].children()[0].@type );
			return 	objectClass = getSerializedObjectFromXML(xml[0].children()[0].children(), objectClass);
		}
		
		/**
		 * 
		 * @private
		 * 
		 */		
		protected static function getSerializedObjectFromXML(xmlChildren:XMLList, objectClass:*):*
		{
			for(var i:int = 0; i < xmlChildren.length(); i++)
			{
				var propType:String  = xmlChildren[i].@type;
				var objectProperty:* = (GetIterativeTypes.isTopLevelObjectTypeIgnoringIterativeItems(propType)) ? PropertyFactory.getDataTypedObject(propType, xmlChildren[i].toString()) 
																												 :  populateIterativeObject(xmlChildren[i].children(), PropertyFactory.getDataTypedObject(propType));
				objectClass[xmlChildren[i].name()] = objectProperty;
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
				var objectClass:*	= PropertyFactory.getDataTypedObject( xmlChildren[i].@type );
				objectClass 		= getSerializedObjectFromXML(xmlChildren[i].children(), objectClass);
				
				if(iterativeObject.hasOwnProperty(SerializerEnums.ADD_ITEM)) iterativeObject.addItem(objectClass);
				else 														 iterativeObject[i] = objectClass;
			}
			
			return iterativeObject;
		}
	}
}