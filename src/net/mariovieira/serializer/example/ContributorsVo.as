package net.mariovieira.serializer.example
{
	public class ContributorsVo
	{
		public function ContributorsVo(){}
		
		[Serialize]
		public var credit:String;
		
		[Serialize]
		public var location:String;
		
		[Serialize]
		public var people:XML;
		
		public var offTheRecordsComment:String;
	}
}