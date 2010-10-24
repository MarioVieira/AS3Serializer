package net.mariovieira.serializer.example
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;

	public class PlaylistItemVo
	{
		public function PlaylistItemVo(){}
		
		[Serialize]
		public var id:Number;
		
		[Serialize]
		public var title:String;
		
		[Serialize]
		public var artist:String;
		
		[Serialize]
		public var album:String;
		
		[Serialize]
		public var contributors:ArrayCollection = new ArrayCollection();
		
		public var dataFromRemoteSite:ByteArray;
	}
}