package org.as3.serializer.example
{
	import flash.utils.ByteArray;
	import mx.collections.ArrayCollection;

	/**
	 *
	 * 
	 * Example value object collection
	 * 
	 * @author Mario Vieira
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