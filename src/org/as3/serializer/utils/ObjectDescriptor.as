package org.as3.serializer.utils
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.olap.aggregators.AverageAggregator;
	
	import org.as3.serializer.enums.SerializerEnums;

	/**
	 * 
	 * @author Mario Vieira
	 * This class describes the object for the Serializer functionality
	 * It uses flash.utils.describeType, flash.utils.getDefinitionByName and flash.utils.getQualifiedClassName
	 * 
	 */	
	public final class ObjectDescriptor
	{
		protected static const OBJECT_DESCRIPTOR_TAGS:Array = [VARIABLE, ACCESSOR];
		protected static const VARIABLE:String 				= 'variable'
		protected static const ACCESSOR:String 				= 'accessor';
		
		/**
		 *
		 * @private 
		 * 
		 */		
		public function ObjectDescriptor(){}
		
		/**
		 * Return an xml of the <code>object</code> properties that received the <code>[Serializer]</code> metadata 
		 * 
		 * @param nodeName It can be either 'variables' or 'accessors', which are node names returned from the object xml (<code>flash.utils.describeType</code>)
		 * @return 
		 * 
		 */
		public static function getSerializerElements(object:Object):XML
		{
			var elements:XML  					= new XML(<elements/>);
			var objectXML:XML 					= describeType(object);
			var variables:XMLList 				= objectXML[VARIABLE];
			var accessors:XMLList				= objectXML[ACCESSOR];
			
			if(variables.length() > 0) elements.appendChild( variables );
			if(accessors.length() > 0) elements.appendChild( accessors );
		
			return elements;
		}
		
		/**
		 * Retrieves the <code>getQualifiedClassName</code> out of the <code>object</code>
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getObjectClass(object:Object):String
		{
			return getDefinitionByName( getQualifiedClassName(object) ).toString();
		}
		
		/**
		 * 
		 * @param object
		 * @param firstCharacterInLowerCase
		 * @return 
		 * 
		 */		
		public static function getClassConstructor(object:Object):String
		{
			var className:String = getObjectClass(object);
			return className.substring(className.indexOf(' ')+1, className.lastIndexOf(']'));
		}
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getClassName(objectOrClass:*):String
		{
			var className:String = getObjectClass(objectOrClass);
			return className.slice(className.indexOf(' ')+1, className.length-1);;	
		}
		
		/**
		 * 
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getObjectType( object:Object ):String
		{
			return getQualifiedClassName(object);
		}
	}
}
