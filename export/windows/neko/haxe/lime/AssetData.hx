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
			path.set ("assets/images/BlueDude.png", "assets/images/BlueDude.png");
			type.set ("assets/images/BlueDude.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/door16x16.png", "assets/images/door16x16.png");
			type.set ("assets/images/door16x16.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/EnemyAxe.png", "assets/images/EnemyAxe.png");
			type.set ("assets/images/EnemyAxe.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/EnemySpear.png", "assets/images/EnemySpear.png");
			type.set ("assets/images/EnemySpear.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/GolemPepe.png", "assets/images/GolemPepe.png");
			type.set ("assets/images/GolemPepe.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/RedDude.png", "assets/images/RedDude.png");
			type.set ("assets/images/RedDude.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Stairs.png", "assets/images/Stairs.png");
			type.set ("assets/images/Stairs.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/tiles.png", "assets/images/tiles.png");
			type.set ("assets/images/tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/titpitoHaxe.png", "assets/images/titpitoHaxe.png");
			type.set ("assets/images/titpitoHaxe.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ZoneA.png", "assets/images/ZoneA.png");
			type.set ("assets/images/ZoneA.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ZoneB.png", "assets/images/ZoneB.png");
			type.set ("assets/images/ZoneB.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ZoneC.png", "assets/images/ZoneC.png");
			type.set ("assets/images/ZoneC.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/music/dungeonsongKachi.mp3", "assets/music/dungeonsongKachi.mp3");
			type.set ("assets/music/dungeonsongKachi.mp3", Reflect.field (AssetType, "music".toUpperCase ()));
			path.set ("assets/music/music-goes-here.txt", "assets/music/music-goes-here.txt");
			type.set ("assets/music/music-goes-here.txt", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
