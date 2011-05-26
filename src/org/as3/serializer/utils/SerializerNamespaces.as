package org.as3.serializer.utils
{
	import org.as3.serializer.enums.SerializerEnums;
	
	/**
	 *@private 
	 * 
	 */
	public class SerializerNamespaces
	{
		public static const SERIALIZER:String				= 'serializer';
		public static const SERIALIZER_NAMESPACE:String		= 'library://org.as3.serializer';
		public static const INVALID_NAME_SPACE:String		= 'Invalid namespace in XML Serializer';
		
		/**
		 *
		 * @private 
		 * 
		 * 
		 */			
		public function SerializerNamespaces(){}
		
		public static function checkNamespace(xml:XML):void
		{
			if( xml.namespace(SERIALIZER)..toString() != SERIALIZER_NAMESPACE) throw new Error(INVALID_NAME_SPACE);
		}
		
		public static function getSerializerNamespace():Namespace
		{   
			return new Namespace(SERIALIZER, SERIALIZER_NAMESPACE);
		}
	}
}