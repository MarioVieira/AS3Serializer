	/*
	
	Mario Vieira, October 2010, Oslo
	
	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
	
	*/

package org.as3.serializer
{

	/**
	 * 
	 * Static class to serialize objects into XML and deseerialize XML into Objects
	 * 
	 * @example
	 * The following serializes objects to XML and deserializes XML to objects:
     *
	 *	<listing version="3.0">
	 *  var object:PlaylistVoCollection = ValueObjectCollectionExample.valueObjectCollection; 
	 *  
	 *  //Returns the XML
	 *  var objectSerializedToXML:XML = Serializer.serializeValuObjectIntoXML( object );
	 * 
	 *  //Returns the typed object
	 *  var serializedObject:PlaylistVoCollection = Serializer.deserializeXMLIntoValuObject( objectSerializedToXML );
	 *  </listing> 
	 * 
	 * @author Mario Vieira
 	 * 
	 */	
	public class Serializer
	{
		/**
		 * 
		 * @param object The object to be serialized into XML
		 * @return The xml Serializer out of the <code>object</code>
		 * 
		 */		
		public static function serialize(object:Object):XML
		{
			return ValueObjectToXML.getSerializerXMLFromObject(object);
		}
		
		/** 
		 * 
		 * @param xml The xml Serializer to be serialized into an Object
		 * @param findClassPackage Option to find a given class package that has changed
		 * @param replaceClassPackage Option to replace a provided class package that changed
		 * @return 
		 * 
		 */		
		public static function deserialize(xml:XML, findClassPackage:String = null, replaceClassPackage:String = null):*
		{
			return XMLToValueObject.deserializeXMLIntoObject(xml, findClassPackage, replaceClassPackage);
		}
	}
}