package org.as3.utils.services
{
	import flash.events.*;
	import flash.net.*;
	import flash.net.URLLoader;
	
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 */	
	public class FileUpdater extends URLLoader
	{
		private var _updateSaver:String;
		
		/**
		 *
		 * @private 
		 *  
		 * 
		 */		
		public function FileUpdater(updateSaver:String)
		{
			_updateSaver = updateSaver;
		}    
		
		/**
		 * 
		 * @param fileName The file name
		 * @param fileContent The file content
		 * @param overwrite Whether it should overwrite or append the <code>fileContent</code> to the file
		 * 
		 */		
		public function updateFile(fileName:String, fileContent:String, overwrite:Boolean = true):void
		{	
			send(fileName, fileContent, false, !overwrite); 
		}
		
		/**
		 * 
		 * @param fileName The file name and extension to be deleted
		 * 
		 */		
		public function deleteFile(fileName:String):void
		{
			send(fileName, null, true); 
		}
		
		/**
		 * 
		 * @param fileName The file name
		 * @param fileContent The file content
		 * @param deleteFile Whether is should delete the file
		 * @param append Whether it should append the <code>fileContent</code> to the file
		 * 
		 */		
		private function send(fileName:String, fileContent:String, deleteFile:Boolean, append:Boolean = false):void
		{
			var req:URLRequest 		= new URLRequest(_updateSaver);
			var vars:URLVariables 	= new URLVariables();
			vars.deleteFile			= deleteFile;
			vars.content 			= fileContent;
			vars.fileName 			= fileName;
			vars.append	 			= append;
			req.data 				= vars;
			req.method 				= URLRequestMethod.POST;
			
			  
			load(req);
		}
	}
}