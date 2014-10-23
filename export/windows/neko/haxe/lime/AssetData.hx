package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/basic.oel", "assets/data/basic.oel");
			type.set ("assets/data/basic.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/data-goes-here.txt", "assets/data/data-goes-here.txt");
			type.set ("assets/data/data-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/room-001.oel", "assets/data/room-001.oel");
			type.set ("assets/data/room-001.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/testLevel.oep", "assets/data/testLevel.oep");
			type.set ("assets/data/testLevel.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/tilemap.oep", "assets/data/tilemap.oep");
			type.set ("assets/data/tilemap.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Corpse_Party_Background.png", "assets/images/Corpse_Party_Background.png");
			type.set ("assets/images/Corpse_Party_Background.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/images-go-here.txt", "assets/images/images-go-here.txt");
			type.set ("assets/images/images-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/lawn_tile.png", "assets/images/lawn_tile.png");
			type.set ("assets/images/lawn_tile.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/titpitoHaxe.png", "assets/images/titpitoHaxe.png");
			type.set ("assets/images/titpitoHaxe.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/sounds-go-here.txt", "assets/sounds/sounds-go-here.txt");
			type.set ("assets/sounds/sounds-go-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
