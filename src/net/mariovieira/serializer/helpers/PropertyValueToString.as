package net.mariovieira.serializer.helpers
{
	import mx.collections.XMLListCollection;
	
	/**
	 *  
	 * @author Mario Vieira
	 * This class checks whether the object is of XML type to retun toString() or toXMLString()
	 * 
	 */	
	public class PropertyValueToString
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function PropertyValueToString(){}
		
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
			return (value is XML || value is XMLList || value is XMLListCollection) ? value.toXMLString() : value.toString();
		}
	}
}