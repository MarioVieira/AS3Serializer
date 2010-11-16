package net.mariovieira.serializer.example
{
	//import fr.kapit.KapInspect;
	
	import net.mariovieira.serializer.utils.Serializer;

	public class SerializerExample
	{
		public var objectSerializedFromXML:PlaylistVoCollection;
		public var xmlFromValueObject:XML;
		
		public function SerializerExample()
		{
			//KapInspect.addDebugItem(this, 'SerializerExample', this);
		}
		
		public function serializeVoToXML():void
		{
			xmlFromValueObject 		= Serializer.serializeValueObjectIntoXML( _valueObjectOrigin );
		}
	
		public function deserializeXMLIntoObject():void
		{
			objectSerializedFromXML = Serializer.deserializeXMLIntoValuObject( xmlFromValueObject );
		}
		
		//underscore here to help with the visualization in the Kap inspector(alphabetical order)
		public function get _valueObjectOrigin():PlaylistVoCollection
		{
			//create ValueObject 
			var playlist:PlaylistVoCollection = new PlaylistVoCollection();
			playlist.title = 'my playlist';
			playlist.isPublic = true;
			
			//add three PlaylistItemVo in the PlaylistVoCollection item property (ArrayCollection)
			for(var i:int = 1; i < 4; i++)
			{
				//create the value object to be added
				var playlistItem:PlaylistItemVo = new PlaylistItemVo();
				
				playlistItem.title 	= 'my tune '+ i;
				playlistItem.album 	= 'album '+ i;
				playlistItem.artist = 'artist '+ i;
				playlistItem.id		= Math.floor( Math.random() * 100);
				
				//add three ContributorsVo in each PlaylistItemVo contributors property (ArrayCollection)
				for(var j:int = 1; j < 4; j++) 
				{
					var contributors:ContributorsVo = new ContributorsVo();
					contributors.credit 	= 'credit '+i;
					contributors.location 	= 'location'+i;
					contributors.people 	= XML(<root><people><person>Mario</person><person>Vieira</person></people></root>);
					
					playlistItem.contributors.addItem(contributors);
				} 
				
				playlist.items.addItem(playlistItem);
			}
			
			return playlist;
		}
	}
}