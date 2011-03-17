package org.as3.serializer.example
{
	import flash.utils.ByteArray;
	import mx.collections.ArrayCollection;

	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * Example value object collection
	 * 
	 */	
	public class PlaylistVoCollection
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function PlaylistVoCollection(){}
		
		/**
		 * [Serialize]
		 */
		[Serialize]   
		public var title:String;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var isPublic:Boolean;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var items:ArrayCollection = new ArrayCollection();
		
		/**
		 * won't be serialized
		 */
		public var adBanner:ByteArray;
		
	}
}