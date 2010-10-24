package net.mariovieira.serializer.persister.events
{
	import flash.events.Event;
	
	public class PersisterEvent extends Event
	{
		public static const ON_RETRIEVED:String = 'onRetrieved';
		public static const ON_UPDATED:String 	= 'onUpdated';
		public static const ON_DESTROY:String 	= 'onDestroyed';
		
		private var _retrievedItem:*;
		
		public function PersisterEvent(type:String, retrievedItem:* = null)
		{
			_retrievedItem = retrievedItem;
			super(type, false, false);
		}
		
		public function get retrievedItem():*
		{
			return _retrievedItem;
		}
		
		override public function clone():Event
		{
			return new PersisterEvent(type, retrievedItem); 
		}
	}
}