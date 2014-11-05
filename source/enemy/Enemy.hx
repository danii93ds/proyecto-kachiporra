package enemy ;
import flash.utils.CompressionAlgorithm;
import flixel.FlxSprite;
import openfl.Vector;
import Status;
import flixel.util.FlxRandom;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}
 
class Enemy extends FlxSprite
{
	//movement variables
	private var _posX:Int;
	private var _posY:Int;
	
	public var dijkstra:Dijkstra;
	public var path:Vector<Node>;
	
	private var MOVEMENT_SPEED:Float = 1;
	private var moveMap:FlxTilemap;
	private var TILE_SIZE:Int = 16;
	public var moveToNextTile:Bool;
	private var moveDirection:MoveDirection;
	#if mobile
	private var _virtualPad:FlxVirtualPad;
	#end
	public var moveUp:Bool;
	public var moveDown:Bool;
	public var moveLeft:Bool;
	public var moveRight:Bool;
	
	//Health
	private var _currentHealth:Int;
	private var _Health:Int;
	
	//Strength
	private var _Strength:Int;
	
	//Defense
	private var _Defense:Int;
	
	//Dexterity
	private var _Dexterity:Int;
	
	//Damage
	private var _swordDamageMin:Int;
	private var _swordDamageMax:Int;
	private var _swordDamageMultiplier:Float;
	
	private var _gunDamageMin:Int;
	private var _gunDamageMax:Int;
	
	//Status	
	private var _status:List<Status>;

	public function new(X:Float=0, Y:Float=0,_mWalls:FlxTilemap) 
	{
		//posiciones que le manda para que aparezca el personaje
		super(X, Y );
		loadGraphic(AssetPaths.EnemySpear__png, true, 16, 16);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		#if mobile
		_virtualPad = new FlxVirtualPad(FULL, NONE);
		_virtualPad.alpha = 0.5;
		FlxG.state.add(_virtualPad);
		#end
		moveMap = new FlxTilemap();
		moveMap = _mWalls;
		
		//Health
		_currentHealth = 100;
		_Health = 100;
	
		//Strength
		_Strength = 5;
		
		//Defense
		_Defense = 5;
		
		//Dexterity
		_Dexterity = 5;
		
		//Damage
		_swordDamageMin = 2;
		_swordDamageMax = 5;
		//SwordDamageMultiplier Min = 0.8 Max = 1.2
	
		_gunDamageMin = 4;
		_gunDamageMax = 7;
		
		_status = new List<Status>();
	}
	
	public function Movement(path:Vector<Node>)
	{
		
	}
		
	public function setStatus(statusName:String):Void {
		var found:Bool = false;
		for (status in _status)
			if (status.getName() == statusName) found = true;
		
		if (!found) {
			var newStatus:Status = new Status(statusName, -1);
			
			if (statusName == "Slowed") { found = true; /*attackSpeed-*/ };
			if (statusName == "Stuned") newStatus.setTurns(2);
			if (statusName == "Poisoned") newStatus.setTurns(5);
			if (statusName == "OnFire") newStatus.setTurns(3);
			
			_status.push(newStatus);
		}

	}
	
	public function cureStatus(statusName:String):Void {
		var removed:Bool = false;
		var statusFound:Status = new Status("",0);
		for (status in _status){
			if (status.getName() == statusName) {
				removed = true;
				statusFound = status;
			}
		}
			
		if (removed) {
		
			//if (statusName == "Slowed") { }
			//if (statusName == "Stuned") found = true;
			//if (statusName == "Poisoned") found = true;
			//if (statusName == "OnFire") found = true;
			_status.remove(statusFound);
			
		}
	}
	
	public function calculateStatusXTurn() {
		for (status in _status){
			if (status.getName() == "Poisoned") _currentHealth -= Math.round(_Health  * 0.02); // 10% x 5 turns
			if (status.getName() == "On Fire") _currentHealth -= Math.round(_Health  * 0.05); //  15% x 3 turns
			status.setTurns(status.getTurns() - 1);
			if (status.getTurns() <= 0) cureStatus(status.getName());
		}
	}
	
	public function attackMelee():Int {
		return FlxRandom.intRanged(cast _swordDamageMin + (_Strength * 0.8),cast _swordDamageMax + (_Strength * 1.2));
	}
	
	public function attackRange():Int {
		return FlxRandom.intRanged(cast _gunDamageMin,cast _gunDamageMax);
	}
		
}