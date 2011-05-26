package org.as3.serializer.persister.events
{
	import flash.events.Event;
	
	/**
	 * 
	 * 
	 * Events for the SerializerCRUD
	 * 
	 * @author Mario Vieira
	 * 
	 * 
	 */	
	public class PersisterEvent extends Event
	{
		/**
		 * 
		 */
		public static const ON_RETRIEVED:String = 'onRetrieved';
		/**
		 * 
		 */
		public static const ON_UPDATED:String 	= 'onUpdated';
		/**
		 * 
		 */
		public static const ON_DESTROY:String 	= 'onDestroyed';
		
		/**
		 *
		 * @private 
		 * 
		 * 
		 */	
		private var _retrievedItem:*;
		
		/**
		 * 
		 * @param type The event type
		 * @param retrievedItem The deserialized object
		 * 
		 */		
		public function PersisterEvent(type:String, retrievedItem:* = null, cancelable:Boolean = false)
		{
			_retrievedItem = retrievedItem;
			super(type, false, cancelable);
		}
		
		/**
		 * 
		 * @return The serialized object on its provided class type
		 * 
		 */		
		public function get retrievedItem():*
		{
			return _retrievedItem;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new PersisterEvent(type, retrievedItem, cancelable); 
		}
	}
}