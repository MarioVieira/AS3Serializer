package org.as3.serializer.utils
{
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;

	/**
	 * 
	 * This provides checks for iterative type based on the qualified class names
	 * The main purpose of this class is to avoid tied coupling the Serializer to Flex collections, otherwise a simple 'is' check would do
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	
	public final class GetObjectType
	{
		//By declaring them here, it's not necesseary to import nor the flash or mx collections (to in both, Flash and FlashBuilder/Flex)
		protected static const ARRAY_COLLECTION:String 		= 'mx.collections::ArrayCollection';
		protected static const ARRAY_LIST:String 			= 'mx.collections::ArrayList';
		
		//top level
		public static const ARRAY:String 				= 'Array';
		public static const VECTOR:String 				= 'Vector';
		public static const NUMBER:String				= 'Number';
		public static const STRING:String				= 'String';
		public static const INT:String					= 'int';
		public static const UINT:String					= 'uint';
		public static const BOOLEAN:String				= 'Boolean';
		public static const OBJECT:String				= 'Object';
		public static const XML:String					= 'XML';
		public static const XMLLIST:String				= 'XMLList';
		
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function GetObjectType(){}
		
		/**
		 * 
		 * @param object The object in which the check needs to be performed
		 * @return 
		 * 
		 */		
		public static function isIterativeObjectType(object:*):Boolean
		{
			var type:String = ObjectDescriptor.getObjectType(object);
			return isIterativeType(type);	
		}
		
		/**
		 * 
		 * @param type The type in which the check needs to be performed
		 * @return 
		 * 
		 */		
		public static function isIterativeType(type:String):Boolean
		{
			return (type == ARRAY || type == ARRAY_COLLECTION || type.search( VECTOR ) != -1 || type == ARRAY_LIST);	
		}
		
	
		/**
		 * This method is used when factoring objects. Casting String into top level objects is fine as long as the are not iterative items (eg: Array)
		 * If they are iterative, the Serializer functionality will also factory their indexed objects
		 * 
		 * @param type The object type
		 * @return 
		 * 
		 */		
		public static function isTopLevelObjectTypeIgnoringIterativeItems(type:String):Boolean
		{	
			//faster than looping in an Array
			return (type == STRING || type == BOOLEAN || type == NUMBER || type == INT || 
					type == UINT || type == XML || type == XMLLIST || type == OBJECT);
		}
			
	}
}