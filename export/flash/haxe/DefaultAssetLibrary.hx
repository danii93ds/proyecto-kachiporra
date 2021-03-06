package;


import haxe.Timer;
import haxe.Unserializer;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.text.Font;
import openfl.media.Sound;
import openfl.net.URLRequest;
import openfl.utils.ByteArray;
import openfl.Assets;

#if (flash || js)
import openfl.display.Loader;
import openfl.events.Event;
import openfl.net.URLLoader;
#end

#if sys
import sys.FileSystem;
#end

#if ios
import openfl.utils.SystemPath;
#end


@:access(openfl.media.Sound)
class DefaultAssetLibrary extends AssetLibrary {
	
	
	public var className (default, null) = new Map <String, Dynamic> ();
	public var path (default, null) = new Map <String, String> ();
	public var type (default, null) = new Map <String, AssetType> ();
	
	private var lastModified:Float;
	private var timer:Timer;
	
	
	public function new () {
		
		super ();
		
		#if flash
		
		className.set ("assets/data/basic.oel", __ASSET__assets_data_basic_oel);
		type.set ("assets/data/basic.oel", AssetType.TEXT);
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		className.set ("assets/data/room-001.oel", __ASSET__assets_data_room_001_oel);
		type.set ("assets/data/room-001.oel", AssetType.TEXT);
		className.set ("assets/data/testLevel.oep", __ASSET__assets_data_testlevel_oep);
		type.set ("assets/data/testLevel.oep", AssetType.TEXT);
		className.set ("assets/data/tilemap.oep", __ASSET__assets_data_tilemap_oep);
		type.set ("assets/data/tilemap.oep", AssetType.TEXT);
		className.set ("assets/images/BlueDude.png", __ASSET__assets_images_bluedude_png);
		type.set ("assets/images/BlueDude.png", AssetType.IMAGE);
		className.set ("assets/images/door16x16.png", __ASSET__assets_images_door16x16_png);
		type.set ("assets/images/door16x16.png", AssetType.IMAGE);
		className.set ("assets/images/EnemyAxe.png", __ASSET__assets_images_enemyaxe_png);
		type.set ("assets/images/EnemyAxe.png", AssetType.IMAGE);
		className.set ("assets/images/EnemySpear.png", __ASSET__assets_images_enemyspear_png);
		type.set ("assets/images/EnemySpear.png", AssetType.IMAGE);
		className.set ("assets/images/Food.png", __ASSET__assets_images_food_png);
		type.set ("assets/images/Food.png", AssetType.IMAGE);
		className.set ("assets/images/Gold.png", __ASSET__assets_images_gold_png);
		type.set ("assets/images/Gold.png", AssetType.IMAGE);
		className.set ("assets/images/GolemPepe.png", __ASSET__assets_images_golempepe_png);
		type.set ("assets/images/GolemPepe.png", AssetType.IMAGE);
		className.set ("assets/images/Player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/Player.png", AssetType.IMAGE);
		className.set ("assets/images/RedDude.png", __ASSET__assets_images_reddude_png);
		type.set ("assets/images/RedDude.png", AssetType.IMAGE);
		className.set ("assets/images/Stairs.png", __ASSET__assets_images_stairs_png);
		type.set ("assets/images/Stairs.png", AssetType.IMAGE);
		className.set ("assets/images/StairsUp.png", __ASSET__assets_images_stairsup_png);
		type.set ("assets/images/StairsUp.png", AssetType.IMAGE);
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		className.set ("assets/images/titpitoHaxe.png", __ASSET__assets_images_titpitohaxe_png);
		type.set ("assets/images/titpitoHaxe.png", AssetType.IMAGE);
		className.set ("assets/images/ZoneA.png", __ASSET__assets_images_zonea_png);
		type.set ("assets/images/ZoneA.png", AssetType.IMAGE);
		className.set ("assets/images/ZoneB.png", __ASSET__assets_images_zoneb_png);
		type.set ("assets/images/ZoneB.png", AssetType.IMAGE);
		className.set ("assets/images/ZoneBver2.png", __ASSET__assets_images_zonebver2_png);
		type.set ("assets/images/ZoneBver2.png", AssetType.IMAGE);
		className.set ("assets/images/ZoneC.png", __ASSET__assets_images_zonec_png);
		type.set ("assets/images/ZoneC.png", AssetType.IMAGE);
		className.set ("assets/images/ZoneCver2.png", __ASSET__assets_images_zonecver2_png);
		type.set ("assets/images/ZoneCver2.png", AssetType.IMAGE);
		className.set ("assets/music/dungeonsongKachi.mp3", __ASSET__assets_music_dungeonsongkachi_mp3);
		type.set ("assets/music/dungeonsongKachi.mp3", AssetType.MUSIC);
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		#elseif html5
		
		var id;
		id = "assets/data/basic.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/data-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/room-001.oel";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/testLevel.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/data/tilemap.oep";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/images/BlueDude.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/door16x16.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/EnemyAxe.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/EnemySpear.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Food.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Gold.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/GolemPepe.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Player.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/RedDude.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/Stairs.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/StairsUp.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/tiles.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/titpitoHaxe.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ZoneA.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ZoneB.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ZoneBver2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ZoneC.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/images/ZoneCver2.png";
		path.set (id, id);
		type.set (id, AssetType.IMAGE);
		id = "assets/music/dungeonsongKachi.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/music/music-goes-here.txt";
		path.set (id, id);
		type.set (id, AssetType.TEXT);
		id = "assets/sounds/beep.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		id = "assets/sounds/flixel.mp3";
		path.set (id, id);
		type.set (id, AssetType.MUSIC);
		
		
		#else
		
		#if (windows || mac || linux)
		
		var useManifest = false;
		
		className.set ("assets/data/basic.oel", __ASSET__assets_data_basic_oel);
		type.set ("assets/data/basic.oel", AssetType.TEXT);
		
		className.set ("assets/data/data-goes-here.txt", __ASSET__assets_data_data_goes_here_txt);
		type.set ("assets/data/data-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/data/room-001.oel", __ASSET__assets_data_room_001_oel);
		type.set ("assets/data/room-001.oel", AssetType.TEXT);
		
		className.set ("assets/data/testLevel.oep", __ASSET__assets_data_testlevel_oep);
		type.set ("assets/data/testLevel.oep", AssetType.TEXT);
		
		className.set ("assets/data/tilemap.oep", __ASSET__assets_data_tilemap_oep);
		type.set ("assets/data/tilemap.oep", AssetType.TEXT);
		
		className.set ("assets/images/BlueDude.png", __ASSET__assets_images_bluedude_png);
		type.set ("assets/images/BlueDude.png", AssetType.IMAGE);
		
		className.set ("assets/images/door16x16.png", __ASSET__assets_images_door16x16_png);
		type.set ("assets/images/door16x16.png", AssetType.IMAGE);
		
		className.set ("assets/images/EnemyAxe.png", __ASSET__assets_images_enemyaxe_png);
		type.set ("assets/images/EnemyAxe.png", AssetType.IMAGE);
		
		className.set ("assets/images/EnemySpear.png", __ASSET__assets_images_enemyspear_png);
		type.set ("assets/images/EnemySpear.png", AssetType.IMAGE);
		
		className.set ("assets/images/Food.png", __ASSET__assets_images_food_png);
		type.set ("assets/images/Food.png", AssetType.IMAGE);
		
		className.set ("assets/images/Gold.png", __ASSET__assets_images_gold_png);
		type.set ("assets/images/Gold.png", AssetType.IMAGE);
		
		className.set ("assets/images/GolemPepe.png", __ASSET__assets_images_golempepe_png);
		type.set ("assets/images/GolemPepe.png", AssetType.IMAGE);
		
		className.set ("assets/images/Player.png", __ASSET__assets_images_player_png);
		type.set ("assets/images/Player.png", AssetType.IMAGE);
		
		className.set ("assets/images/RedDude.png", __ASSET__assets_images_reddude_png);
		type.set ("assets/images/RedDude.png", AssetType.IMAGE);
		
		className.set ("assets/images/Stairs.png", __ASSET__assets_images_stairs_png);
		type.set ("assets/images/Stairs.png", AssetType.IMAGE);
		
		className.set ("assets/images/StairsUp.png", __ASSET__assets_images_stairsup_png);
		type.set ("assets/images/StairsUp.png", AssetType.IMAGE);
		
		className.set ("assets/images/tiles.png", __ASSET__assets_images_tiles_png);
		type.set ("assets/images/tiles.png", AssetType.IMAGE);
		
		className.set ("assets/images/titpitoHaxe.png", __ASSET__assets_images_titpitohaxe_png);
		type.set ("assets/images/titpitoHaxe.png", AssetType.IMAGE);
		
		className.set ("assets/images/ZoneA.png", __ASSET__assets_images_zonea_png);
		type.set ("assets/images/ZoneA.png", AssetType.IMAGE);
		
		className.set ("assets/images/ZoneB.png", __ASSET__assets_images_zoneb_png);
		type.set ("assets/images/ZoneB.png", AssetType.IMAGE);
		
		className.set ("assets/images/ZoneBver2.png", __ASSET__assets_images_zonebver2_png);
		type.set ("assets/images/ZoneBver2.png", AssetType.IMAGE);
		
		className.set ("assets/images/ZoneC.png", __ASSET__assets_images_zonec_png);
		type.set ("assets/images/ZoneC.png", AssetType.IMAGE);
		
		className.set ("assets/images/ZoneCver2.png", __ASSET__assets_images_zonecver2_png);
		type.set ("assets/images/ZoneCver2.png", AssetType.IMAGE);
		
		className.set ("assets/music/dungeonsongKachi.mp3", __ASSET__assets_music_dungeonsongkachi_mp3);
		type.set ("assets/music/dungeonsongKachi.mp3", AssetType.MUSIC);
		
		className.set ("assets/music/music-goes-here.txt", __ASSET__assets_music_music_goes_here_txt);
		type.set ("assets/music/music-goes-here.txt", AssetType.TEXT);
		
		className.set ("assets/sounds/beep.mp3", __ASSET__assets_sounds_beep_mp3);
		type.set ("assets/sounds/beep.mp3", AssetType.MUSIC);
		
		className.set ("assets/sounds/flixel.mp3", __ASSET__assets_sounds_flixel_mp3);
		type.set ("assets/sounds/flixel.mp3", AssetType.MUSIC);
		
		
		if (useManifest) {
			
			loadManifest ();
			
			if (Sys.args ().indexOf ("-livereload") > -1) {
				
				var path = FileSystem.fullPath ("manifest");
				lastModified = FileSystem.stat (path).mtime.getTime ();
				
				timer = new Timer (2000);
				timer.run = function () {
					
					var modified = FileSystem.stat (path).mtime.getTime ();
					
					if (modified > lastModified) {
						
						lastModified = modified;
						loadManifest ();
						
						if (eventCallback != null) {
							
							eventCallback (this, "change");
							
						}
						
					}
					
				}
				
			}
			
		}
		
		#else
		
		loadManifest ();
		
		#end
		#end
		
	}
	
	
	public override function exists (id:String, type:AssetType):Bool {
		
		var assetType = this.type.get (id);
		
		#if pixi
		
		if (assetType == IMAGE) {
			
			return true;
			
		} else {
			
			return false;
			
		}
		
		#end
		
		if (assetType != null) {
			
			if (assetType == type || ((type == SOUND || type == MUSIC) && (assetType == MUSIC || assetType == SOUND))) {
				
				return true;
				
			}
			
			#if flash
			
			if ((assetType == BINARY || assetType == TEXT) && type == BINARY) {
				
				return true;
				
			} else if (path.exists (id)) {
				
				return true;
				
			}
			
			#else
			
			if (type == BINARY || type == null) {
				
				return true;
				
			}
			
			#end
			
		}
		
		return false;
		
	}
	
	
	public override function getBitmapData (id:String):BitmapData {
		
		#if pixi
		
		return BitmapData.fromImage (path.get (id));
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), BitmapData);
		
		#elseif openfl_html5
		
		return BitmapData.fromImage (ApplicationMain.images.get (path.get (id)));
		
		#elseif js
		
		return cast (ApplicationMain.loaders.get (path.get (id)).contentLoaderInfo.content, Bitmap).bitmapData;
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), BitmapData);
		else return BitmapData.load (path.get (id));
		
		#end
		
	}
	
	
	public override function getBytes (id:String):ByteArray {
		
		#if (flash)
		
		return cast (Type.createInstance (className.get (id), []), ByteArray);

		#elseif (js || openfl_html5 || pixi)
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			bytes = new ByteArray ();
			bytes.writeUTFBytes (data);
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}

		if (bytes != null) {
			
			bytes.position = 0;
			return bytes;
			
		} else {
			
			return null;
		}
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), ByteArray);
		else return ByteArray.readFile (path.get (id));
		
		#end
		
	}
	
	
	public override function getFont (id:String):Font {
		
		#if pixi
		
		return null;
		
		#elseif (flash || js)
		
		return cast (Type.createInstance (className.get (id), []), Font);
		
		#else
		
		if (className.exists(id)) {
			var fontClass = className.get(id);
			Font.registerFont(fontClass);
			return cast (Type.createInstance (fontClass, []), Font);
		} else return new Font (path.get (id));
		
		#end
		
	}
	
	
	public override function getMusic (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif openfl_html5
		
		var sound = new Sound ();
		sound.__buffer = true;
		sound.load (new URLRequest (path.get (id)));
		return sound; 
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, true);
		
		#end
		
	}
	
	
	public override function getPath (id:String):String {
		
		#if ios
		
		return SystemPath.applicationDirectory + "/assets/" + path.get (id);
		
		#else
		
		return path.get (id);
		
		#end
		
	}
	
	
	public override function getSound (id:String):Sound {
		
		#if pixi
		
		return null;
		
		#elseif (flash)
		
		return cast (Type.createInstance (className.get (id), []), Sound);
		
		#elseif js
		
		return new Sound (new URLRequest (path.get (id)));
		
		#else
		
		if (className.exists(id)) return cast (Type.createInstance (className.get (id), []), Sound);
		else return new Sound (new URLRequest (path.get (id)), null, type.get (id) == MUSIC);
		
		#end
		
	}
	
	
	public override function getText (id:String):String {
		
		#if js
		
		var bytes:ByteArray = null;
		var data = ApplicationMain.urlLoaders.get (path.get (id)).data;
		
		if (Std.is (data, String)) {
			
			return cast data;
			
		} else if (Std.is (data, ByteArray)) {
			
			bytes = cast data;
			
		} else {
			
			bytes = null;
			
		}
		
		if (bytes != null) {
			
			bytes.position = 0;
			return bytes.readUTFBytes (bytes.length);
			
		} else {
			
			return null;
		}
		
		#else
		
		var bytes = getBytes (id);
		
		if (bytes == null) {
			
			return null;
			
		} else {
			
			return bytes.readUTFBytes (bytes.length);
			
		}
		
		#end
		
	}
	
	
	public override function isLocal (id:String, type:AssetType):Bool {
		
		#if flash
		
		if (type != AssetType.MUSIC && type != AssetType.SOUND) {
			
			return className.exists (id);
			
		}
		
		#end
		
		return true;
		
	}
	
	
	public override function list (type:AssetType):Array<String> {
		
		var items = [];
		
		for (id in this.type.keys ()) {
			
			if (type == null || exists (id, type)) {
				
				items.push (id);
				
			}
			
		}
		
		return items;
		
	}
	
	
	public override function loadBitmapData (id:String, handler:BitmapData -> Void):Void {
		
		#if pixi
		
		handler (getBitmapData (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBitmapData (id));
			
		}
		
		#else
		
		handler (getBitmapData (id));
		
		#end
		
	}
	
	
	public override function loadBytes (id:String, handler:ByteArray -> Void):Void {
		
		#if pixi
		
		handler (getBytes (id));
		
		#elseif (flash || js)
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				var bytes = new ByteArray ();
				bytes.writeUTFBytes (event.currentTarget.data);
				bytes.position = 0;
				
				handler (bytes);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getBytes (id));
			
		}
		
		#else
		
		handler (getBytes (id));
		
		#end
		
	}
	
	
	public override function loadFont (id:String, handler:Font -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getFont (id));
			
		//}
		
		#else
		
		handler (getFont (id));
		
		#end
		
	}
	
	
	#if (!flash && !html5)
	private function loadManifest ():Void {
		
		try {
			
			#if blackberry
			var bytes = ByteArray.readFile ("app/native/manifest");
			#elseif tizen
			var bytes = ByteArray.readFile ("../res/manifest");
			#elseif emscripten
			var bytes = ByteArray.readFile ("assets/manifest");
			#else
			var bytes = ByteArray.readFile ("manifest");
			#end
			
			if (bytes != null) {
				
				bytes.position = 0;
				
				if (bytes.length > 0) {
					
					var data = bytes.readUTFBytes (bytes.length);
					
					if (data != null && data.length > 0) {
						
						var manifest:Array<Dynamic> = Unserializer.run (data);
						
						for (asset in manifest) {
							
							if (!className.exists (asset.id)) {
								
								path.set (asset.id, asset.path);
								type.set (asset.id, Type.createEnum (AssetType, asset.type));
								
							}
							
						}
						
					}
					
				}
				
			} else {
				
				trace ("Warning: Could not load asset manifest (bytes was null)");
				
			}
		
		} catch (e:Dynamic) {
			
			trace ('Warning: Could not load asset manifest (${e})');
			
		}
		
	}
	#end
	
	
	public override function loadMusic (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getMusic (id));
			
		//}
		
		#else
		
		handler (getMusic (id));
		
		#end
		
	}
	
	
	public override function loadSound (id:String, handler:Sound -> Void):Void {
		
		#if (flash || js)
		
		/*if (path.exists (id)) {
			
			var loader = new Loader ();
			loader.contentLoaderInfo.addEventListener (Event.COMPLETE, function (event) {
				
				handler (cast (event.currentTarget.content, Bitmap).bitmapData);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {*/
			
			handler (getSound (id));
			
		//}
		
		#else
		
		handler (getSound (id));
		
		#end
		
	}
	
	
	public override function loadText (id:String, handler:String -> Void):Void {
		
		#if js
		
		if (path.exists (id)) {
			
			var loader = new URLLoader ();
			loader.addEventListener (Event.COMPLETE, function (event:Event) {
				
				handler (event.currentTarget.data);
				
			});
			loader.load (new URLRequest (path.get (id)));
			
		} else {
			
			handler (getText (id));
			
		}
		
		#else
		
		var callback = function (bytes:ByteArray):Void {
			
			if (bytes == null) {
				
				handler (null);
				
			} else {
				
				handler (bytes.readUTFBytes (bytes.length));
				
			}
			
		}
		
		loadBytes (id, callback);
		
		#end
		
	}
	
	
}


#if pixi
#elseif flash

@:keep class __ASSET__assets_data_basic_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_data_data_goes_here_txt extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_data_room_001_oel extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_data_testlevel_oep extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_data_tilemap_oep extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_images_bluedude_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_door16x16_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_enemyaxe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_enemyspear_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_food_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_gold_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_golempepe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_reddude_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_stairs_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_stairsup_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_titpitohaxe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_zonea_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_zoneb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_zonebver2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_zonec_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_images_zonecver2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep class __ASSET__assets_music_dungeonsongkachi_mp3 extends openfl.media.Sound { }
@:keep class __ASSET__assets_music_music_goes_here_txt extends openfl.utils.ByteArray { }
@:keep class __ASSET__assets_sounds_beep_mp3 extends openfl.media.Sound { }
@:keep class __ASSET__assets_sounds_flixel_mp3 extends openfl.media.Sound { }


#elseif html5






























#elseif (windows || mac || linux)


@:file("assets/data/basic.oel") class __ASSET__assets_data_basic_oel extends flash.utils.ByteArray {}
@:file("assets/data/data-goes-here.txt") class __ASSET__assets_data_data_goes_here_txt extends flash.utils.ByteArray {}
@:file("assets/data/room-001.oel") class __ASSET__assets_data_room_001_oel extends flash.utils.ByteArray {}
@:file("assets/data/testLevel.oep") class __ASSET__assets_data_testlevel_oep extends flash.utils.ByteArray {}
@:file("assets/data/tilemap.oep") class __ASSET__assets_data_tilemap_oep extends flash.utils.ByteArray {}
@:bitmap("assets/images/BlueDude.png") class __ASSET__assets_images_bluedude_png extends flash.display.BitmapData {}
@:bitmap("assets/images/door16x16.png") class __ASSET__assets_images_door16x16_png extends flash.display.BitmapData {}
@:bitmap("assets/images/EnemyAxe.png") class __ASSET__assets_images_enemyaxe_png extends flash.display.BitmapData {}
@:bitmap("assets/images/EnemySpear.png") class __ASSET__assets_images_enemyspear_png extends flash.display.BitmapData {}
@:bitmap("assets/images/Food.png") class __ASSET__assets_images_food_png extends flash.display.BitmapData {}
@:bitmap("assets/images/Gold.png") class __ASSET__assets_images_gold_png extends flash.display.BitmapData {}
@:bitmap("assets/images/GolemPepe.png") class __ASSET__assets_images_golempepe_png extends flash.display.BitmapData {}
@:bitmap("assets/images/Player.png") class __ASSET__assets_images_player_png extends flash.display.BitmapData {}
@:bitmap("assets/images/RedDude.png") class __ASSET__assets_images_reddude_png extends flash.display.BitmapData {}
@:bitmap("assets/images/Stairs.png") class __ASSET__assets_images_stairs_png extends flash.display.BitmapData {}
@:bitmap("assets/images/StairsUp.png") class __ASSET__assets_images_stairsup_png extends flash.display.BitmapData {}
@:bitmap("assets/images/tiles.png") class __ASSET__assets_images_tiles_png extends flash.display.BitmapData {}
@:bitmap("assets/images/titpitoHaxe.png") class __ASSET__assets_images_titpitohaxe_png extends flash.display.BitmapData {}
@:bitmap("assets/images/ZoneA.png") class __ASSET__assets_images_zonea_png extends flash.display.BitmapData {}
@:bitmap("assets/images/ZoneB.png") class __ASSET__assets_images_zoneb_png extends flash.display.BitmapData {}
@:bitmap("assets/images/ZoneBver2.png") class __ASSET__assets_images_zonebver2_png extends flash.display.BitmapData {}
@:bitmap("assets/images/ZoneC.png") class __ASSET__assets_images_zonec_png extends flash.display.BitmapData {}
@:bitmap("assets/images/ZoneCver2.png") class __ASSET__assets_images_zonecver2_png extends flash.display.BitmapData {}
@:sound("assets/music/dungeonsongKachi.mp3") class __ASSET__assets_music_dungeonsongkachi_mp3 extends flash.media.Sound {}
@:file("assets/music/music-goes-here.txt") class __ASSET__assets_music_music_goes_here_txt extends flash.utils.ByteArray {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/beep.mp3") class __ASSET__assets_sounds_beep_mp3 extends flash.media.Sound {}
@:sound("C:/HaxeToolkit/haxe/lib/flixel/3,3,5/assets/sounds/flixel.mp3") class __ASSET__assets_sounds_flixel_mp3 extends flash.media.Sound {}


#end
