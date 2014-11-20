package enemy ;
import flash.utils.CompressionAlgorithm;
import flixel.FlxSprite;
import items.Gold;
import openfl.geom.Rectangle;
import openfl.Vector;
import Status;
import flixel.util.FlxRandom;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import flixel.util.FlxPoint;
import items.Item;
import items.food.ingredients.RawMeat;

/**
 * ...
 * @author ...
 */

 
class Enemy extends FlxSprite
{
	//movement variables
	public var dijkstra:Dijkstra;
	public var thisRoom:Rectangle;
	public var player:Player;
	public var currentPlayPos:FlxPoint;
	public var storedPlayPos:FlxPoint;
	private var MOVEMENT_SPEED:Float = 1;
	public var path:Vector<Node>;
	private var TILE_SIZE:Int = 16;
	public var moveToNextTile:Bool;
	#if mobile
	private var _virtualPad:FlxVirtualPad;
	#end
	public var moveUp:Bool;
	public var moveDown:Bool;
	public var moveLeft:Bool;
	public var moveRight:Bool;
	public var moveMap:FlxTilemap;
	public var _allRooms:Vector<Rectangle>;
	
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
	
	//Experience
	private var _Exp:Int;
	private var _Level:Int;

	public function new(X:Float=0, Y:Float=0,allRooms:Vector<Rectangle>,_mWalls,_player:Player) 
	{
		//posiciones que le manda para que aparezca el personaje
		super(X , Y );
		loadGraphic(AssetPaths.EnemySpear__png, true, 16, 16);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		_Level = _player.getLevel();
		_Exp = 100 * _Level;
		
		#if mobile
		_virtualPad = new FlxVirtualPad(FULL, NONE);
		_virtualPad.alpha = 0.5;
		FlxG.state.add(_virtualPad);
		#end
		moveMap = _mWalls;
		
		player = _player;
		currentPlayPos = new FlxPoint();
		storedPlayPos = new FlxPoint();
		
		_allRooms = allRooms;
		//inicializa el comportamiento del chobi
		for (room in _allRooms)
		{
			if (room.contains(Std.int(x / 16) ,Std.int(y / 16)))
			{
				thisRoom = room;
			}
		}
		if(thisRoom != null)
			dijkstra = new Dijkstra(thisRoom);
		
		
		
		//Health
		_currentHealth = 20  + (5 * _Level);
		_Health = 20 + (5 * _Level);
	
		//Strength
		_Strength = 5 + cast (1 * _Level);
		
		//Defense
		_Defense = 5 + cast (1 * _Level);
		
		//Dexterity
		_Dexterity = 5 + cast (1 * _Level);
		
		//Damage
		_swordDamageMin = 2 + (2 * _Level);
		_swordDamageMax = 5 + (4 * _Level);
		//SwordDamageMultiplier Min = 0.8 Max = 1.2
	
		_gunDamageMin = 4 + (2* _Level);
		_gunDamageMax = 7 + (4 * _Level);
		
		_status = new List<Status>();
	}
	
	public function MovementIdle()
	{
			
	}
	
	public function MovementChase()
	{		
		var myPos:FlxPoint = new FlxPoint(Std.int(x / TILE_SIZE), Std.int( y / TILE_SIZE));
		
		if(path == null)
			path = dijkstra.ChoosePath(moveMap, player, myPos);
		
		//hacerlo smooth
		x = path[1].x * TILE_SIZE;
		y = path[1].y * TILE_SIZE;
	
		
		storedPlayPos.x = currentPlayPos.x;
		storedPlayPos.y = currentPlayPos.y;
		
		path = null;
	}

	public function getDamage(damage:Int) {
		_currentHealth -= (damage - Math.round((_Defense) / 3));
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
	
	private function dropItem():Item {
		if (FlxRandom.intRanged(0,3) != 5)
			return new RawMeat();
		return null;
	}
	
	private function dropGold():Item {
		if (FlxRandom.intRanged(0, 3) != 1){
			return new Gold(FlxRandom.intRanged((_Level - 1) * 5 == 0 ? 1 : (_Level - 1) * 5, 5 * _Level)); 
		}
		return null;
	}
	
	
	public function Die(player:Player, pS:PlayState ) {
		if (_currentHealth <= 0) {
			player.setExp(_Exp);
			FlxG.log.add(_Exp + " experience gained");
			var drop:Item = null;
			if (FlxRandom.intRanged(0,1) == 0){
				drop = dropItem();
				if (drop != null)
					drop.loadGraphic(AssetPaths.Food__png, false, 16, 16);
			}
			else{
				drop = dropGold();
				if (drop != null)
					drop.loadGraphic(AssetPaths.Gold__png, false, 16, 16);
			}			
			FlxG.log.add(drop);
			if (drop != null){
				drop.x = this.x;
				drop.y = this.y;
				pS.add(drop);
			}
			
			player._enemies.remove(this);
			kill();
			destroy();
		}
	}
	
	override public function update():Void 
	{
		//actualiza la posicion del jugador
		if (thisRoom.contains(Std.int(player.x / TILE_SIZE),Std.int(player.y / TILE_SIZE)))
		{		
			if ((player.x % TILE_SIZE) == 0 && (player.y % TILE_SIZE) == 0)
			{
				currentPlayPos.x = player.x;
				currentPlayPos.y = player.y;
			}
		}
		else 
			MovementIdle();
		//si la posicion del jugador cambia recalculamos path	
		if (currentPlayPos.x != storedPlayPos.x || currentPlayPos.y != storedPlayPos.y)
		{
			MovementChase();
		}
		
		super.update();
	}
}