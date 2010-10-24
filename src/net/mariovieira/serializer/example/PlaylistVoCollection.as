package net.mariovieira.serializer.example
{
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;

	public class PlaylistVoCollection
	{
		public function PlaylistVoCollection(){}
		
		[Serialize] 
		public var title:String;
		
		[Serialize]
		public var isPublic:Boolean;
		
		[Serialize]
		public var items:ArrayCollection = new ArrayCollection();
		
		public var adBanner:ByteArray;
		
	}
}