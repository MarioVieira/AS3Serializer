package org.as3.serializer.example
{
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * Example value object
	 * 
	 */	
	public class ContributorsVo
	{
		/**
		 *
		 * @private 
		 * 
		 * 
		 */		
		public function ContributorsVo(){}
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var credit:String;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var location:String;
		
		/**
		 * [Serialize]
		 */
		[Serialize]
		public var people:XML;
		
		/**
		 * will not be serialized
		 */
		public var offTheRecordsComment:String;
	}
}