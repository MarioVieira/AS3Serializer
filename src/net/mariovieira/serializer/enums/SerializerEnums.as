package net.mariovieira.serializer.enums
{
	/**
	 * 
	 * @author Mario Vieira
	 * Enumarations used over the serialization
	 */	
	public class SerializerEnums
	{
		public function SerializerEnums(){}
		
		public static const S_ERIALIZE:String 				= 'Serialize';
		public static const SERIALIZER:String 				= 'serializer';
		
		//xml element names for an object properties (vars or accessor pairs) returned by the global member describeType(object:Object):XML
		public static const VARIABLE:String 				= 'variable';
		public static const ACCESSOR:String					= 'accessor';
	
		public static const ITERATIVE:String				= 'iterative';
		
		//to check  if the iterative item is IList
		public static const ADD_ITEM:String			 		= 'addItem';
		//to cast bolleans check
		public static const FALSE:String			 		= 'false';
		
		public static const XML_VERSION:String		=  '<?xml version="1.0"?>\n';
	}
}