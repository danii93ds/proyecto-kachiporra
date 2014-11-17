package ;

import enemy.Dijkstra;
import flash.display.BitmapData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import map.MapDistribution;
import openfl.Vector;
import openfl.display.Graphics;
import openfl.geom.ColorTransform;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flash.geom.Rectangle;
import flixel.FlxCamera;
import flash.display.Sprite;
import map.BSPgenerator;
import map.MapDistribution;
import haxe.Timer;
import flixel.util.FlxColor;
import enemy.Enemy;

import flixel.util.FlxRandom; //  Kachiporra !!
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	//MAP VARIABLES
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var bsp:BSPgenerator;
	public var allRooms:Vector<Rectangle> = new Vector<Rectangle>();//stores all the rooms
	public var mapDistr:MapDistribution;
	//MAP DISTRIBUTION VARIABLES
	public var entrance:FlxSprite;
	public var exit:FlxSprite;
	//PLAYER VARIABLES
	private var _player:Player;
	private var _playerSet:Bool = false;
	//ENEMY VARIABLES
	public var _enemySpear:FlxTypedGroup<Enemy>;
	public var enemy:Enemy;
 
	public var currentZone:String = "ZoneA"; //  Kachiporra:	por ahora cambiar por ZoneA, ZoneB, ZoneC para ver dif niveles
	
	override public function create():Void
	{
		
		
		//SETEO, DIBUJADO DEL MAPA
		_map = new FlxOgmoLoader("assets/data/basic.oel");
		
		/*
		_mWalls = _map.loadTilemap("assets/images/tiles.png", 16, 16, "walls");
		// esto es para definir qué pasa en caso de colisionar con los tiles
		_mWalls.setTileProperties(0, FlxObject.NONE);
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		*/
		
		LoadTileMap(_map);		//  Kachiporra:		Carga los Tiles, segun el currentZone
		
		
		add(_mWalls);
		bsp = new BSPgenerator();
		bsp.CreateLeafs();
		DrawDungeon();

		//DISTRIBUCION DEL MAPA
		mapDistr = new MapDistribution(allRooms);
		entrance = new FlxSprite(mapDistr.entrancePos.x, mapDistr.entrancePos.y);
		entrance.loadGraphic(AssetPaths.Stairs__png, true, 16, 16);
		add(entrance);
		exit = new FlxSprite(mapDistr.exitPos.x, mapDistr.exitPos.y);
		exit.loadGraphic(AssetPaths.Stairs__png, true, 16, 16);
		add(exit);
		
		
		//ENEMY
		_enemySpear = new FlxTypedGroup();
		add(_enemySpear);
		for (pos in mapDistr.enemySpawn)
			_enemySpear.add(new Enemy(pos.x * 16 , pos.y  * 16, allRooms,_mWalls));
		
		
		
		
		//PLAYER
		_player = new Player(mapDistr.playerStartPos.x,mapDistr.playerStartPos.y,_mWalls,_enemySpear);
		_player.drag.x = _player.drag.y = 3200;
		_player.offset.set(0, 0);
		add(_player);
		
		
		
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN_TIGHT, 1);	
		FlxG.camera.fade(FlxColor.BLACK,1,true);
		super.create();
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}
	
	private function CheckEnemyVision(e:Enemy):Void
	{
		if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint()))
		{
			e.seesPlayer = true;
			e.playerPos.copyFrom(_player.GetPosistion());
		}else
			e.seesPlayer = false;
	}

	override public function update():Void
	{
		super.update();
		if (FlxG.overlap(_player,exit))
		{
			FlxG.camera.fade(FlxColor.BLACK,.33, false,function() {
			FlxG.switchState(new PlayState());
			});
		}
	}
	
	
	
	public function DrawDungeon():Void
	{
		for (leaf in bsp._leafs)
		{

			if(leaf.leftChild == null || leaf.rightChild == null)
			{
				var startX = Std.int(leaf.room.x);
				var startY = Std.int(leaf.room.y);
				var destX = Std.int(leaf.room.width) + startX;
				var destY = Std.int(leaf.room.height) + startY;
				allRooms.push(leaf.room);//stores all rooms

				for (i in startX...destX)
				{
					for (j in startY...destY)
					{
						//_mWalls.setTile(i, j, 8);
						SetFloorTile(i, j);				//Kachiporra: mete floor tiles, segun CurrentZone
					}
				}
			}	
		}
		for (leaf in bsp._leafs)
		{
			if (leaf.halls != null)
			{
				for (hall in leaf.halls)
				{
					var hX = Std.int(hall.x);
					var hY = Std.int(hall.y);
					var finalhX = Std.int(hall.width) + hX;
					var finalhY = Std.int(hall.height) + hY;
					for (i in hX...finalhX)
					{
						for (j in hY...finalhY)
						{
							//_mWalls.setTile(i, j, 8);
							SetFloorTile(i, j);		//Kachiporra: mete floor tiles, segun CurrentZone
						}
					}
				}
			}
		}
		RemoveExtraWallTiles();	//  Kachiporra:  Elimino las paredes q estan rodeadas de paredes
		SetWallTiles();			//  Kachiporra:  Vario las paredes restantes, segun CurrentZone
	}
	
	//------------
	//------------
	
	public function LoadTileMap(map:FlxOgmoLoader):Void
	{
		if (currentZone == "ZoneA")
		{
			_mWalls = _map.loadTilemap("assets/images/ZoneA.png", 16, 16, "walls");
			_mWalls.setTileProperties(0, FlxObject.NONE);	//Empty Tile
			_mWalls.setTileProperties(1, FlxObject.NONE);	//Wall 1
			_mWalls.setTileProperties(2, FlxObject.NONE);	//Wall 2
			_mWalls.setTileProperties(3, FlxObject.NONE);	//Wall 3
			_mWalls.setTileProperties(4, FlxObject.NONE);	//Wall con detalle 1
			_mWalls.setTileProperties(5, FlxObject.NONE);	//Wall con detalle 2
			_mWalls.setTileProperties(6, FlxObject.NONE);	//Wall con detalle 3
			_mWalls.setTileProperties(7, FlxObject.NONE);	//Floor 1
			_mWalls.setTileProperties(8, FlxObject.NONE);	//Floor 2
			_mWalls.setTileProperties(9, FlxObject.NONE);	//Floor 3
			_mWalls.setTileProperties(10, FlxObject.NONE);	//Floor 4	
			_mWalls.setTileProperties(11, FlxObject.NONE);	//Floor con Hongos de los buenos
			_mWalls.setTileProperties(12, FlxObject.NONE);	//Floor con piedras
			_mWalls.setTileProperties(13, FlxObject.NONE);	//Floor con Charco agua
			_mWalls.setTileProperties(14, FlxObject.NONE);	//Floor con esqueleto 
			
		}
		if (currentZone == "ZoneB")
		{
			_mWalls = _map.loadTilemap("assets/images/ZoneB.png", 16, 16, "walls");
			_mWalls.setTileProperties(0, FlxObject.NONE);	//Empty Tile
			_mWalls.setTileProperties(1, FlxObject.NONE);	//Wall
			_mWalls.setTileProperties(2, FlxObject.NONE);
			_mWalls.setTileProperties(3, FlxObject.NONE);
			_mWalls.setTileProperties(4, FlxObject.NONE);
			_mWalls.setTileProperties(5, FlxObject.NONE);
			_mWalls.setTileProperties(6, FlxObject.NONE);	//Wall
			_mWalls.setTileProperties(7, FlxObject.NONE);	//Floor
			_mWalls.setTileProperties(8, FlxObject.NONE);
			_mWalls.setTileProperties(9, FlxObject.NONE);
			_mWalls.setTileProperties(10, FlxObject.NONE);
			_mWalls.setTileProperties(11, FlxObject.NONE);
			_mWalls.setTileProperties(12, FlxObject.NONE);
			_mWalls.setTileProperties(13, FlxObject.NONE);
		}
		if (currentZone == "ZoneC")
		{
			_mWalls = _map.loadTilemap("assets/images/ZoneC.png", 16, 16, "walls");
			_mWalls.setTileProperties(0, FlxObject.NONE);	//Empty Tile
			_mWalls.setTileProperties(1, FlxObject.NONE);	//Wall
			_mWalls.setTileProperties(2, FlxObject.NONE);
			_mWalls.setTileProperties(3, FlxObject.NONE);
			_mWalls.setTileProperties(4, FlxObject.NONE);
			_mWalls.setTileProperties(5, FlxObject.NONE);
			_mWalls.setTileProperties(6, FlxObject.NONE);	
			_mWalls.setTileProperties(7, FlxObject.NONE);	//Wall
			_mWalls.setTileProperties(8, FlxObject.NONE);	//Floor
		}
	}
	
	public function RemoveExtraWallTiles():Void // Funca, pero problemas en las paredes de los extremos.
	{
		
		var array = new Array<Array<Int>>();
		var arrayIndex:Int = 0;
		for (x in 0..._mWalls.widthInTiles)
		{
			for (y in 0..._mWalls.heightInTiles)
			{
				var temp = _mWalls.getTile(x, y);
				if (temp == 2)
				{
					if (_mWalls.getTile(x+1, y) == 2 && _mWalls.getTile(x-1,y) == 2 && _mWalls.getTile(x, y+1) == 2 && _mWalls.getTile(x , y-1) == 2 &&
						_mWalls.getTile(x+1, y+1) == 2 &&	_mWalls.getTile(x-1, y-1) == 2 && _mWalls.getTile(x+1, y-1) == 2 &&	_mWalls.getTile(x-1, y+1) == 2)
					{
						array[arrayIndex] = [x, y];
						arrayIndex++;
					}
					
					
				}
			}
		}
		for (x in 0...array.length)
		{
			var temp = new Array<Int>();
			temp = array[x];
			_mWalls.setTile((temp[0]), temp[1], 0);
		}
	}
	
	public function SetWallTiles():Void
	{
		for (x in 0..._mWalls.widthInTiles)
		{
			for (y in 0..._mWalls.heightInTiles)
			{
				var temp = _mWalls.getTile(x, y);
				if (temp == 2)
				{
					if (currentZone == "ZoneA")
					{
						if (FlxRandom.intRanged(0, 10) < 9) { _mWalls.setTile(x, y, FlxRandom.intRanged(1 , 3)); }
						else {_mWalls.setTile(x, y, FlxRandom.intRanged(4 , 6));}
					}
					if (currentZone == "ZoneB")
					{
						
						if (FlxRandom.intRanged(0, 10) < 8) { _mWalls.setTile(x, y, 2); }
						else {_mWalls.setTile(x, y, FlxRandom.intRanged(1 , 6));}
					}
					if (currentZone == "ZoneC")
					{
						if (FlxRandom.intRanged(0, 10) < 8) { _mWalls.setTile(x, y, 2); }
						else {_mWalls.setTile(x, y, FlxRandom.intRanged(1 , 7));}
					}
				}
			}
		}
	}
	
	public function SetFloorTile(x:Int, y:Int):Void
	{
		if (currentZone == "ZoneA")
		{
			if (FlxRandom.intRanged(0, 10) < 10) { _mWalls.setTile(x, y, FlxRandom.intRanged(7 , 10)); }
			else {_mWalls.setTile(x, y, FlxRandom.intRanged(11 , 14));}			
		}
		if (currentZone == "ZoneB")
		{
			if (FlxRandom.intRanged(0, 10) < 10) { _mWalls.setTile(x, y, FlxRandom.intRanged(7 , 10)); }
			else {_mWalls.setTile(x, y, FlxRandom.intRanged(11 , 13));}							
		}
		if (currentZone == "ZoneC")
		{
			_mWalls.setTile(x, y,8);			
		}
	}
	
	
	//------------
	//------------
	
	
	
	
	
	
	
	
	
	
	
	
}