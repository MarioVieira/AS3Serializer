package org.as3.serializer.helpers
{
	/**
	 *  
	 * @author Mario Vieira
	 * Checks whether the object is of XML type to retun toString() or toXMLString()
	 * 
	 */	
	public class ValueToString
	{
		/**
		 *
		 * @private 
		 * 
		 */
		protected static const XML_CONST:String = 'XML';
		
		/**
		 * Returns property values as Strings to be used within the Serializer xml elements
		 * This is used for non-iterative items only
		 *  
		 * @param value
		 * @return 
		 * 
		 */	
		public static function toString(value:*):String
		{
			if(value) return ( ObjectDescriptor.getClassConstructor( value ).search(XML_CONST) == -1) ? String(value) : value.toXMLString();
			else return null;  
		}
	}
}