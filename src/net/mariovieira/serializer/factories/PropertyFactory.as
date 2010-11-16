package net.mariovieira.serializer.factories
{	
	import flash.utils.getDefinitionByName;
	
	import net.mariovieira.serializer.enums.SerializerEnums;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * This class factories properties, and although it's called Factory it did not need a Facade
	 * 
	 */	
	public class PropertyFactory
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function PropertyFactory(){}
		
		/**
		 * 
		 * @param qualifiecClassName The name of the class which you want an object from
		 * @param propertyValue If provided cast a String value to the typed object (if possible)
		 * @return The object of type specified in the <code>qualifiecClassName</code> parameter
		 * 
		 */		
		public static function getDataTypedObject(classNameAndPackage:String, propertyValue:String = null):*
		{
			var ClassReference:Class = getDefinitionByName( classNameAndPackage ) as Class;
			return (!propertyValue || propertyValue == SerializerEnums.FALSE) ? new ClassReference() : new ClassReference(propertyValue); //didn't really needed this care, but here it's
		}
	}
}