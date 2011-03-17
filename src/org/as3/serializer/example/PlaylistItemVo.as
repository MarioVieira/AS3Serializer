package org.as3.serializer.example
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * Example value object
	 * 
	 */	
	public class PlaylistItemVo
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function PlaylistItemVo(){}
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var id:Number;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var title:String;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var artist:String;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var album:String;
		
		/**
		 * will not be serialized
		 */
		[Serialize]
		public var contributors:ArrayCollection = new ArrayCollection();
		
		public var dataFromRemoteSite:ByteArray;
	}
}