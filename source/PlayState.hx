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
	
	
	
	override public function create():Void
	{
		
		//SETEO, DIBUJADO DEL MAPA
		_map = new FlxOgmoLoader("assets/data/basic.oel");
		_mWalls = _map.loadTilemap("assets/images/tiles.png", 16, 16, "walls");
		// esto es para definir qué pasa en caso de colisionar con los tiles
		_mWalls.setTileProperties(0, FlxObject.NONE);
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.ANY);
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
		
		//PLAYER
		_player = new Player(mapDistr.playerStartPos.x,mapDistr.playerStartPos.y,_mWalls);
		_player.drag.x = _player.drag.y = 3200;
		//_player.setSize(8, 14);
		_player.offset.set(0, 0);
		add(_player);
		
		//ENEMY
		_enemySpear = new FlxTypedGroup();
		add(_enemySpear);
		for (pos in mapDistr.enemySpawn)
			_enemySpear.add(new Enemy(pos.x * 16 , pos.y  * 16, _mWalls));
		
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
		FlxG.collide(_enemySpear, _player);
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
						_mWalls.setTile(i, j, 1);
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
							_mWalls.setTile(i, j, 1);
						}
					}
				}
			}
		}
	}
}