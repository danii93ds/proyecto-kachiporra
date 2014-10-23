package;

import flash.display.BitmapData;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import openfl.Vector;
import openfl.display.Graphics;
import openfl.geom.ColorTransform;
import flash.display.Sprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flash.geom.Rectangle;
import flixel.FlxCamera;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	//MAP VAIRABLES
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var bsp:BSPgenerator;
	//PLAYER VARIABLES
	private var _player:Player;
	private var _playerSet:Bool = false;
	
	
	override public function create():Void
	{
		
		//SETEO Y DIBUJADO DEL MAPA
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
		
		
		//PLAYER
		_player = new Player(96, 96);
		_player.drag.x = _player.drag.y = 3200;
		_player.setSize(8, 14);
		_player.offset.set(4, 2);
		add(_player);
		
		
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN_TIGHT, 1);	
		super.create();
	}
	

	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
		FlxG.collide(_player, _mWalls);
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