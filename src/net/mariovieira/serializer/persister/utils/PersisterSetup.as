package net.mariovieira.serializer.persister.utils
{
	import net.mariovieira.serializer.utils.Serializer;
	import net.mariovieira.serializer.persister.enums.PersisterEnums;
	import net.mariovieira.serializer.persister.vo.PersiterInfo;
	import net.mariovieira.utils.services.FileUpdater;
	
	/**
	 * 
	 * @author Mario Vieira
	 * 
	 * This class sets up the informatio necessary to persist the XML files from the serialized objects (UTF8)
	 * 
	 */	
	public class PersisterSetup
	{	
		private static const DEFAULT_FILE_SUFFIX:String 		=  'serializedObject_';
		private static const DEFAULT_XML_CONFIG_FILENAME:String =  'SerializerPersisterModel.xml';
		
		public function PersisterSetup(){}
	
		/**
		 * 
		 * @param configXMLFileName The name of the config file
		 * @param updaterPhpUrl	The url and file name of the php updater
		 * @param filePrefix A file name preffix to be added to the serialized value object names
		 * @param fileSuffix Optional string to be added to the file name of the serialized xml
		 * @return 
		 * 
		 */		
		public static function setupPersister(updaterPhpUrl:String, configXMLFileName:String = DEFAULT_XML_CONFIG_FILENAME, filePrefix:String = DEFAULT_FILE_SUFFIX, fileSuffix:String = ''):void
		{
			var info:PersiterInfo = new PersiterInfo();
			info.filePrefix		  = filePrefix;
			info.fileSuffix		  = fileSuffix;
			info.phpUpdater		  = updaterPhpUrl;
			
			var saveFile:FileUpdater = new FileUpdater(updaterPhpUrl);
			saveFile.updateFile(configXMLFileName, 
								Serializer.serializeValueObjectIntoXML(info).toXMLString() );
		}
	}
}