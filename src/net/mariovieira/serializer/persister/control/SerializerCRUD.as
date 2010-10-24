package net.mariovieira.serializer.persister.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import net.mariovieira.serializer.helpers.ObjectDescriptor;
	import net.mariovieira.serializer.persister.enums.PersisterEnums;
	import net.mariovieira.serializer.persister.events.PersisterEvent;
	import net.mariovieira.serializer.utils.Serializer;
	import net.mariovieira.utils.services.FileUpdater;

	[Event(name="onRetrieved", type="net.mariovieira.serializer.persister.events.PersisterEvent")]
	
	public class SerializerCRUD extends EventDispatcher
	{
		private var _updater:FileUpdater;
		private var _apacheFolder:String;
		
		public function SerializerCRUD(apacheFolder:String)
		{
			_apacheFolder = hasForwadSlash(apacheFolder);
			_updater 	  = new FileUpdater(apacheFolder + PersisterEnums.PHP_UPDATER);
		}
		
		/**
		 * Update/Create
		 *  
		 * @param object Object to be serialized and persisted
		 * @param id
		 * 
		 */		
		public function update(object:Object, uniqueId:uint):void
		{
			_updater.updateFile( getItemFileName(object, uniqueId), Serializer.serializeValuObjectIntoXML(object).toXMLString() );
		}
		
		/**
		 * Destroys the object 
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
		 * Retrieves the data typed object
		 *  
		 * @param objectClass
		 * @param id
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
		
		private function onRetrieve(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, onRetrieve);
			dispatchEvent( new PersisterEvent(PersisterEvent.ON_RETRIEVED, Serializer.deserializeXMLIntoValuObject( XML(event.target.data) )));
		}
		
		private function getItemFileName(objectOrClass:*, uniqueId:uint):String
		{
			return ObjectDescriptor.getClassName(objectOrClass) + PersisterEnums.UNDERSCORE + uniqueId.toString() + PersisterEnums.XML_EXTENSION;
		}
		
		private function hasForwadSlash(value:String):String
		{
			if( value.substring(value.length - 1) != '/' ) value += '/';
			return value;
		}
	}
}