package ;

/**
 * ...
 * @author nachotorres
 */
import flixel.addons.tile.FlxRayCastTilemap;
import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import items.food.cooked.Sandwich;
import items.combat.bullets.Bullet;
import items.combat.Armor;
import items.combat.Gun;
import items.combat.Sword;
import openfl.geom.Point;
import openfl.Vector;
import flixel.util.FlxRandom;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
import flixel.FlxObject;
import items.Item;
import enemy.Enemy;
import Helper;
import Status;
 
class Player extends FlxSprite
{
	

	//movement variables
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
	public var _enemies:FlxTypedGroup<Enemy>;
	public var areEnemiesUp:Bool = false;
	public var areEnemiesDown:Bool = false;
	public var areEnemiesLeft:Bool = false;
	public var areEnemiesRight:Bool = false;
	
	//Health  5 per level
	private var _healthBase:Int;
	private var _currentHealth:Int;
	private var _Health:Int;
	private var _bonusHealth:Int;
	private var _HealthXLevel:Int;
	
	//Strength  +1 select per level
	private var _Strength:Int;
	private var _bonusStrenght:Int;
	
	//Defense +1 select per level
	private var _Defense:Int;
	private var _bonusArmor:Int;
	private var _bonusDefense:Int;
	private var _Armor:Armor;
	
	//Dexterity +1 select per level
	private var _Dexterity:Int;
	private var _bonusDexterity:Int;
	
	//Sword 
	private var _Sword:Sword;
	private var _swordDamageMultiplier:Float;
	
	//Gun
	private var _Gun:Gun;
	
	//Survival	
	private var _Fear:Int;
	private var _Hungry:Int;
	private var _Energy:Int;
	
	//Status
	private var _status:List<Status>;
	
	//Inventory
	private var _Inventory:Inventory;
	private var _Kachis:UInt;
	
	//Experience
	private var _Experience:Int;
	private var _ExpToNextLevel:Int;
	private var _Level:Int;
	
	
	public function new(X:Float=0, Y:Float=0,_mWalls:FlxTilemap) 
	{
		//posiciones que le manda para que aparezca el personaje
		super(X, Y );
		loadGraphic(AssetPaths.Player__png, true, 16, 16);
		
		setFacingFlip(FlxObject.LEFT, false, false);  
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		// facing solo para sprite derecha o isquierda
		
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
		
		//Experience
		_Experience = 0;
		_ExpToNextLevel = 500;
		_Level = 1;
		
	
		//Health
		_healthBase = 100;
		_currentHealth = 100;
		_Health = 100;
		_bonusHealth = 0;
		_HealthXLevel = 8;
	
		//Strength
		_Strength = 5;
		_bonusStrenght = 0;
		
		//Defense
		_Defense = 5;
		_bonusArmor = 0;
		_bonusDefense = 0;
		
		//Dexterity
		_Dexterity = 5;
		_bonusDexterity = 0;
		
		_Sword = new Sword();
		_Gun = new Gun();
		_Armor = new Armor();
		
		//Survival	
		_Fear = 100;
		_Hungry = 100;
		_Energy = 100;
	
		_status = new List<Status>();
		
		//Inventory
		_Inventory = new Inventory();
		_Inventory._matrix[0][0].setItem(new Sandwich());
		_Inventory._matrix[0][0].setCount(1);
		_Inventory._matrix[0][1].setItem(new Bullet());
		_Inventory._matrix[0][1].setCount(10);
		
		_Kachis = 100;
		
		//Experience
		_Experience = 0;
		_ExpToNextLevel = 500;
		_Level = 1;
		
		
	}
	//CAMBIAR PARA QUE SE MUEVA DE 16 EN 16 (haciendo + no colisiona)
	private function movement():Void
	{
		// Move the player to the next block
		if (moveToNextTile)
		{
			switch (moveDirection)
			{
				case UP:
					if (moveUp == true && areEnemiesUp != true)
					{
						y -= MOVEMENT_SPEED;
						animation.play("u");
					}
				case DOWN:
					if (moveDown == true && areEnemiesDown != true)
					{
						y += MOVEMENT_SPEED;
						animation.play("d");
					}
				case LEFT:
					if (moveLeft == true && areEnemiesLeft != true)
					{
						x -= MOVEMENT_SPEED;
						facing = FlxObject.LEFT;
						animation.play("lr");
					}
				case RIGHT:
					if (moveRight == true && areEnemiesRight != true)
					{
						x += MOVEMENT_SPEED;
						facing = FlxObject.RIGHT;
						animation.play("lr");
					}
			}
		}
		
		// Check if the player has now reached the next block
		if ((x % TILE_SIZE == 0) && (y % TILE_SIZE == 0))
		{
			moveToNextTile = false;
			
			//collision on each direction
			if (moveMap.getTile(Math.round(x / TILE_SIZE), Math.round(y / TILE_SIZE) - 1) <= 6)
				moveUp = false;
			else
				moveUp = true;
			if (moveMap.getTile(Math.round(x / TILE_SIZE), Math.round(y / TILE_SIZE) + 1) <= 6)
				moveDown = false;
			else
				moveDown = true;
			if (moveMap.getTile(Math.round(x / TILE_SIZE) - 1, Math.round(y / TILE_SIZE)) <= 6)
				moveLeft = false;
			else
				moveLeft = true;
			if (moveMap.getTile(Math.round(x / TILE_SIZE) + 1, Math.round(y / TILE_SIZE)) <= 6)
				moveRight = false;
			else
				moveRight = true;
				
				
			//se llama aca porque se sabe que esta en el centro del tile
			areEnemiesUp = areEnemiesDown = areEnemiesLeft = areEnemiesRight = false;
			if (_enemies != null)
				UnitCollision();
			
		}
		
		#if mobile
		if (_virtualPad.buttonDown.status == FlxButton.PRESSED)
		{
			moveTo(MoveDirection.DOWN);
		}
		else if (_virtualPad.buttonUp.status == FlxButton.PRESSED)
		{
			moveTo(MoveDirection.UP);
		}
		else if (_virtualPad.buttonLeft.status == FlxButton.PRESSED)
		{
			moveTo(MoveDirection.LEFT);
		}
		else if (_virtualPad.buttonRight.status == FlxButton.PRESSED)
		{
			moveTo(MoveDirection.RIGHT);
		}
		#else
		// Check for WASD or arrow key presses and move accordingly
		if (FlxG.keys.anyPressed(["DOWN", "S"]))
		{
			moveTo(MoveDirection.DOWN);
		}
		else if (FlxG.keys.anyPressed(["UP", "W"]))
		{
			moveTo(MoveDirection.UP);
		}
		else if (FlxG.keys.anyPressed(["LEFT", "A"]))
		{
			moveTo(MoveDirection.LEFT);
		}
		else if (FlxG.keys.anyPressed(["RIGHT", "D"]))
		{
			moveTo(MoveDirection.RIGHT);
		}
		#end
	}
	
	public function moveTo(Direction:MoveDirection):Void
	{
		// Only change direction if not already moving
		if (!moveToNextTile)
		{
			moveDirection = Direction;
			moveToNextTile = true;
			
		}
		

	}
	
	public function UnitCollision()
	{	
		for (enemy in _enemies)
		{
			if (x == enemy.x && y == enemy.y + TILE_SIZE)
			{
				areEnemiesUp = true;
			}
			if (x == enemy.x && y == enemy.y - TILE_SIZE)
			{
				areEnemiesDown = true;
			}
			if (x == enemy.x + TILE_SIZE && y == enemy.y)
			{
				areEnemiesLeft = true;
			}
			if (x == enemy.x - TILE_SIZE && y == enemy.y)
			{
				areEnemiesRight = true;
			}
		}
	}
	
	public function GetEnemies(enemies:FlxTypedGroup<Enemy>)
	{
		_enemies = enemies;
		
	}
	public function attackCommand():Int {
		 
		if (FlxG.mouse.justPressedRight || FlxG.mouse.justPressed)
		if (!moveToNextTile) 
		{			
			var damage:Int = 0;
			var playerPos:FlxPoint = new FlxPoint(0, 0);
			var toGoPos:FlxPoint = new FlxPoint(0, 0);
			
			
			toGoPos.x = this.x;
			toGoPos.y = this.y;
			playerPos.x = this.x;
			playerPos.y = this.y;
			
			//FlxG.log.add(moveDirection);
			
			if (moveDirection == cast MoveDirection.UP ) {
				if (FlxG.mouse.justPressedRight)
					toGoPos.y = toGoPos.y - 4 * 16;
				else
					toGoPos.y = toGoPos.y - 1 * 16;
				
			}
			if (moveDirection == cast MoveDirection.DOWN) {
				if (FlxG.mouse.justPressedRight)
					toGoPos.y = toGoPos.y + 4 * 16;
				else
					toGoPos.y = toGoPos.y + 1 * 16;
			}
			if (moveDirection == cast MoveDirection.LEFT) {
				if (FlxG.mouse.justPressedRight)
					toGoPos.x = toGoPos.x - 4 * 16;
				else
					toGoPos.x = toGoPos.x - 1 * 16;
			}
			if (moveDirection == cast MoveDirection.RIGHT){
				if (FlxG.mouse.justPressedRight)
					toGoPos.x = toGoPos.x + 4 * 16;
				else
					toGoPos.x = toGoPos.x + 1 * 16;
			}
			
			//FlxG.log.add(playerPos.x + "x " + playerPos.y + "y <- playerPos \n");
			//FlxG.log.add(toGoPos.x + "x " + toGoPos.y + "y <- ToGoPos \n");
			
			//var collided:Bool = rayCastE.ray(playerPos, toGoPos, result;
			
			//if (!collided)
				//FlxG.log.add(result.x + "x " + result.y + "y <- colide in");

			if (FlxG.mouse.justPressed) {
				
				damage = attackMelee();
				//animation attack melee
			}
			if (FlxG.mouse.justPressedRight) {
				
				damage = attackRange();
				//animation attack range
			}
			
			Helper.danyCast(this,playerPos, toGoPos, damage, _enemies, moveDirection);
			
		}
		
		return 0;
	}
	
	
	override public function draw():Void 
	{
		if (velocity.x != 0 || velocity.y != 0)
		{
			switch(facing)
			{
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
					
				case FlxObject.UP:
					animation.play("u");
					
				case FlxObject.DOWN:
					animation.play("d");
			}
		}
			
		super.draw();
	}
	
	private function AddMaxLife(health:Int) 
	{
		_healthBase += health;
	}
	
	private function AddStat(stat:String):Void 
	{ 
		
		switch stat 
		{
			case "Strength":
				_Strength++;
			case "Defense":
				_Defense++;
			case "Dexterity":
				_Dexterity++;
		}
	}
	
	public function LevelUp() //stat:string
	{
		AddStat("Strenght");
		AddStat("Defense");
		AddStat("Dexterity");
		AddMaxLife(_HealthXLevel);
		_ExpToNextLevel += 500 * _Level;
		_Level++;
	}
	
	public function calculateFear():Void 
	{
		if (false) //tileVisibility Dark
			_Fear -= 2;
		else if (false) // tileVisibility Light
			_Fear + 2;
			
		//tileVisibility MidLight
	}
	
	public function setHungry():Void 
	{
		_Hungry -= 3;
	}
	
	public function eat(foodValue:Int)
	{
		_Hungry += foodValue;
		if (_Hungry >= 100) _Hungry = 100;
	}
	
	public function tireEnergy():Void 
	{
		_Energy--;
	}
	
	public function sleep():Void 
	{
		_Energy = 100;
	}
	
	public function setStatus(statusName:String):Void {
		var found:Bool = false;
		for (status in _status)
			if (status.getName() == statusName) found = true;
		
		if (!found) {
			var newStatus:Status = new Status(statusName, -1);
			
			if (statusName == "Fear") _bonusDexterity += -Math.round(_bonusDexterity * 0.25);
			if (statusName == "Terrified") _bonusDexterity += -Math.round(_bonusDexterity * 0.50);
			if (statusName == "Hungry") _bonusStrenght += -Math.round(_bonusStrenght * 0.25);
			if (statusName == "VeryHungry") _bonusStrenght += -Math.round(_bonusStrenght * 0.50);
			if (statusName == "Tired") { _bonusDefense += -Math.round(_bonusDefense * 0.25); /*attackSpeed-*/}
			if (statusName == "Exhaust") {_bonusDefense += -Math.round(_bonusDefense * 0.50); /*attackSpeed--*/}
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
		
			if (statusName == "Fear") _bonusDexterity += Math.round(_bonusDexterity * 0.25);
			if (statusName == "Terrified") _bonusDexterity += Math.round(_bonusDexterity * 0.50);
			if (statusName == "Hungry") _bonusStrenght += Math.round(_bonusStrenght * 0.25);
			if (statusName == "Very Hungry") _bonusStrenght += Math.round(_bonusStrenght * 0.50);
			if (statusName == "Tired") { _bonusDefense += Math.round(_bonusDefense * 0.25); /*attackSpeed+*/}
			if (statusName == "Exhaust") { _bonusDefense += Math.round(_bonusDefense * 0.50); /*attackSpeed++*/ }
			//if (statusName == "Slowed") { }
			//if (statusName == "Stuned") found = true;
			//if (statusName == "Poisoned") found = true;
			//if (statusName == "OnFire") found = true;
			_status.remove(statusFound);
			
		}
	}
	
	public function calculateStatusXTurn() {
		for (status in _status){
			if (status.getName() == "Poisoned") _currentHealth -= Math.round(_healthBase * 0.02); // 10% x 5 turns
			if (status.getName() == "On Fire") _currentHealth -= Math.round(_healthBase * 0.05); //  15% x 3 turns
			status.setTurns(status.getTurns() - 1);
			if (status.getTurns() <= 0) cureStatus(status.getName());
		}
	}
	
	public function attackMelee():Int {
		return FlxRandom.intRanged(cast _Sword.MinDamage() + (_Strength * 0.8),cast _Sword.MaxDamage() + (_Strength * 1.2));
	}
	
	public function attackRange():Int {
		return FlxRandom.intRanged(cast _Gun.MinDamage(),cast _Gun.MaxDamage());
	}
	
	public function GetPosistion():FlxPoint
	{
		var pos:FlxPoint = new FlxPoint(0, 0);
		pos.x = this.x;
		pos.y = this.y;
		return pos;
	}
	
	public function getDamage(damage:Int) {
		_currentHealth -= (damage - Math.round((_Defense + _Armor.Defense()) / 3));
	}
	
	public function getLevel():Int {
		return _Level;
	}
	
	public function setExp(exp:Int) {
		_Experience += exp;
		if (_Experience >= _ExpToNextLevel) {
			_Experience -= _ExpToNextLevel;
			LevelUp();
			FlxG.log.add("Level Up");
		}
			
	}
	
	override public function update():Void 
	{	
		movement();
		attackCommand();
		super.update();
	}
}