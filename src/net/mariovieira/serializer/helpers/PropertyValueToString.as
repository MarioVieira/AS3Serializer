package net.mariovieira.serializer.helpers
{
	import mx.collections.XMLListCollection;
	
	/**
	 *  
	 * @author Mario Vieira
	 * 
	 */	
	public class PropertyValueToString
	{
		public function PropertyValueToString(){}
		
		/**
		 * Returns property values as Strings to be used within the Serializer xml elements
		 * This is used for non-iterative items only
		 *  
		 * @param value
		 * @return 
		 * 
		 */		
		public static function getPropertyValueToString(value:*):String
		{
			return (value is XML || value is XMLList || value is XMLListCollection) ? value.toXMLString() : value.toString();
		}
	}
}