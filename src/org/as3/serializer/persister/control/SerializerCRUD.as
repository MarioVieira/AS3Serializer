package org.as3.serializer.persister.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
	
	import org.as3.serializer.example.PlaylistVoCollection;
	import org.as3.serializer.helpers.ObjectDescriptor;
	import org.as3.serializer.interfaces.ICRUD;
	import org.as3.serializer.persister.enums.PersisterEnums;
	import org.as3.serializer.persister.events.PersisterEvent;
	import org.as3.serializer.utils.Serializer;
	import org.as3.utils.services.FileUpdater;
	
	/**
	 * The event dispatched for the asyncronous <code>retrieve</code> call
	 */	
	[Event(name="onRetrieved", type="org.as3.serializer.persister.events.PersisterEvent")]
	
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
		 * The XML URLLoader exposed in case no EventListeners, but Signals are to be used
		 * 
		 * 
		 */
		public var retriever:URLLoader;
		
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
		 * @private 
		 * 
		 */	
		private var _dispatchRetrievedEvent:Boolean;
		
		/**
		 *
		 * @private 
		 * 
		 */	
		private var _cache:Boolean;
		
		/**
		 * 
		 * @param apacheFolder The Apache service that contains the updater.php
		 * @param cache Whether to allow the browser to cache the xml
		 * @param cache Whether to dispatch the onRetrieved event (not wished if using Signals)
		 * 
		 */		
		public function SerializerCRUD(apacheFolder:String, cache:Boolean, dispatchRetrievedEvent:Boolean)
		{
			retriever 				= new URLLoader();
			_apacheFolder			= hasForwadSlash(apacheFolder);
			_updater 	  			= new FileUpdater(apacheFolder + PersisterEnums.PHP_UPDATER);
			_dispatchRetrievedEvent = dispatchRetrievedEvent;
			_cache					= cache;
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
			if(_dispatchRetrievedEvent) 
			{
				retriever.addEventListener(Event.COMPLETE, onRetrieve);
				retriever.addEventListener(IOErrorEvent.IO_ERROR, onLoadError);
			}
																														//unique time as query string to avoid browser caching
			var request:URLRequest = new URLRequest( _apacheFolder + getItemFileName(objectClass, uniqueId) + (!_cache ? '?' + new Date().getTime() : '') );
			retriever.dataFormat = URLLoaderDataFormat.TEXT;
			retriever.load(request);
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
		
		protected function onLoadError(event:Event):void
		{
			trace('net.mariovieira.serializer.persister.control.SerializerCRUD: Error loading XML');
			dispatchEvent( new PersisterEvent(PersisterEvent.ON_RETRIEVED, null) );
		}
		
	}
}