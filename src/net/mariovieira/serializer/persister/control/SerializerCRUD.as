package net.mariovieira.serializer.persister.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import net.mariovieira.serializer.example.PlaylistVoCollection;
	import net.mariovieira.serializer.helpers.ObjectDescriptor;
	import net.mariovieira.serializer.interfaces.ICRUD;
	import net.mariovieira.serializer.persister.enums.PersisterEnums;
	import net.mariovieira.serializer.persister.events.PersisterEvent;
	import net.mariovieira.serializer.utils.Serializer;
	import net.mariovieira.utils.services.FileUpdater;
	
	/**
	 * The event dispatched for the asyncronous <code>retrieve</code> call
	 */	
	[Event(name="onRetrieved", type="net.mariovieira.serializer.persister.events.PersisterEvent")]
	
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * Provides CRUD operations for the value object serializer
	 * @example
	 * <listing version="3.0"> 
	 * 
	 * var object:PlaylistVoCollection = ValueObjectCollectionExample.valueObjectCollection;
	 * var crud:ICrud = new SerializerCRUDControl('http://localhost:8888/serializer/');
	 * 
	 * //creates an XML file in the Apache server: PlaylistVoCollection_100.xml
	 * crud.update(object, 100); 
	 * 
	 * //URLRequest to the PlaylistVoCollection_100.xml
	 * crud.retrieve(PlaylistVoCollection, 100); 		  
	 * crud.addEventListener(PersisterEvent.ON_RETRIEVED, onRetrieved);
	 * 
	 * //the handler for the retrieve asynchronous call
	 * private function onRetrieved(e:PersisterEvent):void
	 * {	
	 *	  var serializedPlayList:PlaylistVoCollection = e.retrievedItem;
	 * }
	 * 
	 * </listing> 
	 * 
	 */	
	public class SerializerCRUD extends EventDispatcher implements ICRUD
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		private var _updater:FileUpdater;
		
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		private var _apacheFolder:String;
		
		/**
		 * 
		 * @param apacheFolder The Apache service that contains the updater.php
		 * 
		 */		
		public function SerializerCRUD(apacheFolder:String)
		{
			_apacheFolder = hasForwadSlash(apacheFolder);
			_updater 	  = new FileUpdater(apacheFolder + PersisterEnums.PHP_UPDATER);
		}
		
		/**
		 * Updates/Creates the entry
		 *  
		 * @param object Object to be serialized and persisted
		 * @param id
		 * 
		 */		
		public function update(object:Object, uniqueId:uint):void
		{
			_updater.updateFile( getItemFileName(object, uniqueId), Serializer.serializeValueObjectIntoXML(object).toXMLString() );
		}
		
		/**
		 * Destroys the entry
		 *  
		 * @param objectClass
		 * @param id
		 * 
		 */		
		public function destroy(objectClass:Class, uniqueId:uint):void
		{
			_updater.deleteFile( getItemFileName(objectClass, uniqueId) );
		}
		
		/**
		 * Retrieves the entry as a data typed object (asynchronous)
		 * It'll dispatch the actual entry XML since it doesn't have the classes imported, and so it cannot be deserialized in here
		 *  
		 * @param objectClass The Class of the object to be retrieved
		 * @param uniqueId The entry unique identifier
		 * 
		 */		
		public function retrieve(objectClass:Class, uniqueId:uint):void
		{
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onRetrieve);
			
			var request:URLRequest = new URLRequest( _apacheFolder + getItemFileName(objectClass, uniqueId) );
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}
		
		/**
		 *  
		 * @private
		 * 
		 */		
		protected function onRetrieve(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, onRetrieve);
			dispatchEvent( new PersisterEvent(PersisterEvent.ON_RETRIEVED, Serializer.deserializeXMLIntoValuObject( XML(event.target.data)) ));
		}
		/**
		 *  
		 * @private
		 * 
		 */	
		protected function getItemFileName(objectOrClass:*, uniqueId:uint):String
		{
			return ObjectDescriptor.getClassName(objectOrClass) + PersisterEnums.UNDERSCORE + uniqueId.toString() + PersisterEnums.XML_EXTENSION;
		}
		
		/**
		 *  
		 * @private
		 * Makes sure the Apache url provided is a directory
		 */	
		protected function hasForwadSlash(value:String):String
		{
			if( value.substring(value.length - 1) != '/' ) value += '/';
			return value;
		}
	}
}