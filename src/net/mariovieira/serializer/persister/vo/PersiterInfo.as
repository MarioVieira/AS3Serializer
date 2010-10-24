package net.mariovieira.serializer.persister.vo
{
	public class PersiterInfo
	{
		public function PersiterInfo(){}
		
		[Serializer] 
		public var phpUpdater:String;
		
		[Serializer] 
		public var filePrefix:String;
		
		[Serializer] 
		public var fileSuffix:String;
	}
}