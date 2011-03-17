package org.as3.serializer.helpers
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
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
		protected static const OBJECT_DESCRIPTOR_TAGS:Array = ['variable', 'accessor'];
		
		/**
		 *
		 * @private 
		 * 
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
			var accessorAndVariables:XMLList;
			
			for(var i:int; i < OBJECT_DESCRIPTOR_TAGS.length; i++)
			{
				if( objectXML.hasOwnProperty(OBJECT_DESCRIPTOR_TAGS[i]) )
				{
					if(!accessorAndVariables) accessorAndVariables = objectXML[OBJECT_DESCRIPTOR_TAGS[i]];
					else accessorAndVariables.appendChild( objectXML[OBJECT_DESCRIPTOR_TAGS[i]] );
				}
			}
			
			return elements.appendChild( getSerializerNodes(accessorAndVariables) );
		}
		
		
		/**
		 * 
		 * @param nodeName
		 * @param object
		 * @return 
		 * 
		 */		
		public static function getSerializerNodes(list:XMLList):XMLList
		{	
			/*
			var reg:RegExp = new RegExp(SerializerEnums.S_ERIALIZE);
			return xml['variable'].(reg.test( metadata.@name ));//'accessor' 
			*/
			
			var serializerElement:XML = new XML(<element/>);
			
			for(var i:int; i < list.length(); i++)
			{
				if(list[i].metadata.(@name == SerializerEnums.S_ERIALIZE) && String(list[i].metadata.(@name == SerializerEnums.S_ERIALIZE).parent()) != 'undefined') 
					serializerElement.appendChild( list[i].metadata.(@name == SerializerEnums.S_ERIALIZE).parent() );
			}
			
			return serializerElement.children();
			
			/*
			The following WORKED perfectly fine until it's compiled for released :o Oddly enough it only works in debug mode, any RegExp experts there?
			
			var reg:RegExp = new RegExp(SerializerEnums.S_ERIALIZE);
			return xml['variable'].(reg.test( metadata.@name )); //'accessor'
			
			See the following xml. Given that we need to check a child and retrieve the parent of it, it's not possible to use:
			list..metadata.(@name = SerializerEnums.S_ERIALIZE).parent() (since there is no parent for the XMLList "..", nor a reference the childIndex() since it can have more than 1 item)
			<variable name="title" type="String">
				<metadata name="Serialize"/>
			</metadata>
			<variable name="isPublic" type="Boolean">
				<metadata name="Serialize"/>
			</metadata>
			*/
			
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
