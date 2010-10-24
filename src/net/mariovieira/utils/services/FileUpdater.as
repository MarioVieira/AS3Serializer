package net.mariovieira.utils.services
{
	import flash.events.*;
	import flash.net.*;
	import flash.net.URLLoader;

	public class FileUpdater extends URLLoader
	{
		private var _updateSaver:String;
		
		public function FileUpdater(updateSaver:String)
		{
			_updateSaver = updateSaver;
		}    
		
		public function updateFile(fileName:String, fileContent:String, overwrite:Boolean = true):void
		{	
			send(fileName, fileContent, false, !overwrite); 
		}
		
		public function deleteFile(fileName:String):void
		{
			send(fileName, null, true); 
		}
		
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