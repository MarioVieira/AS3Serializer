package net.mariovieira.serializer.helpers
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import net.mariovieira.serializer.enums.SerializerEnums;
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public final class ObjectDescriptor
	{
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
			var elements:XML = new XML(<elements/>);
			elements.appendChild( getSerializerNodes(SerializerEnums.VARIABLE, object) );
			elements.appendChild( getSerializerNodes(SerializerEnums.ACCESSOR, object) );
			return elements;
		}
		
		/**
		 * 
		 * @param nodeName
		 * @param object
		 * @return 
		 * 
		 */		
		protected static function getSerializerNodes(nodeName:String, object:Object):XMLList
		{
			return describeType(object)[nodeName].( /Serialize.*/.test( metadata.@name ) );
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
		public static function getClassConstructor(object:Object, firstCharacterInLowerCase:Boolean = false):String
		{
			var className:String = getObjectClass(object);
			className = className.substring(className.indexOf(' ')+1, className.lastIndexOf(']'));
			
			if(!firstCharacterInLowerCase) return className;
			else return className = className.substr(0, 1).toLowerCase() + className.substring(1);
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
			return classPackageAndNameOutOfQualifiedClassName( getQualifiedClassName(object) );
		}
		
		/**
		 * 
		 * @param qualifiedClassName
		 * @return 
		 * 
		 */		
		public static function classPackageAndNameOutOfQualifiedClassName(qualifiedClassName:String):String
		{
			var lastIndexOfColon:int = qualifiedClassName.indexOf(':');
			
			if(lastIndexOfColon != -1) return qualifiedClassName.substring(0, lastIndexOfColon) + '.' + qualifiedClassName.substr(qualifiedClassName.lastIndexOf(':')+1);
			else return qualifiedClassName;
		}
	}
}
