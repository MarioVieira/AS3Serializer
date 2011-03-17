package org.as3.serializer.factories
{	
	import flash.utils.getDefinitionByName;
	
	import org.as3.serializer.enums.SerializerEnums;
	import org.as3.serializer.helpers.GetObjectType;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * This class factories properties, and although it's called Factory it did not need a Facade
	 * 
	 */	
	public class ObjectFactory
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function ObjectFactory(){}
		
		/**
		 * 
		 * @param qualifiecClassName The name of the class which you want an object from
		 * @param propertyValue If provided cast a String value to the typed object (if possible)
		 * @return The object of type specified in the <code>qualifiecClassName</code> parameter
		 * 
		 */		
		public static function getDataTypedObject(classNameAndPackage:String, propertyValue:* = null, name:String = null):*
		{
			var ClassReference:Class = getDefinitionByName( classNameAndPackage ) as Class;
			var canNotUseConstructor:Boolean = (!propertyValue || (propertyValue.toString() == SerializerEnums.FALSE || (classNameAndPackage == GetObjectType.BOOLEAN && propertyValue.toString() == "")) );
			return  (canNotUseConstructor) ? new ClassReference() : new ClassReference(propertyValue);
		}
	}
}