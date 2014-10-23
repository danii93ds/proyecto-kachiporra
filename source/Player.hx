package ;

/**
 * ...
 * @author nachotorres
 */
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxAngle;
import flixel.FlxG;
import openfl.Vector;
 
class Player extends FlxSprite
{
	
	public var speed:Float = 100;
	
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
	private var _armorDefense:Int;
	private var _bonusArmor:Int;
	private var _bonusDefense:Int;
	
	//Dexterity +1 select per level
	private var _Dexterity:Int;
	private var _bonusDexterity:Int;
	
	//Damage
	private var _swordDamageMin:Int;
	private var _swordDamageMax:Int;
	private var _swordDamageMultiplier:Float;
	
	private var _gunDamageMin:Int;
	private var _gunDamageMax:Int;
		
	//Survival	
	private var _Fear:Int;
	private var _Hungry:Int;
	private var _Energy:Int;
	
	//Status
	private var _status:List<String>;
	
	public function new(X:Float=0, Y:Float=0) 
	{
		//posiciones que le manda para que aparezca el personaje
		super(X, Y );
		loadGraphic(AssetPaths.titpitoHaxe__png, true, 16, 16);
		
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);
		
		
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
		_armorDefense = 5;
		_bonusArmor = 0;
		_bonusDefense = 0;
		
		//Dexterity
		_Dexterity = 5;
		_bonusDexterity = 0;
		
		//Damage
		_swordDamageMin = 2;
		_swordDamageMax = 5;
		//SwordDamageMultiplier Min = 0.8 Max = 1.2
	
		_gunDamageMin = 4;
		_gunDamageMax = 7;
		
		//Survival	
		_Fear = 100;
		_Hungry = 100;
		_Energy = 100;
	
		_status = new List<String>();
	}
	//CAMBIAR PARA QUE SE MUEVA DE 16 EN 16 (haciendo + no colisiona)
	private function movement():Void
	{	
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		
		_up = FlxG.keys.anyPressed(["UP", "W"]);
		_down = FlxG.keys.anyPressed(["DOWN", "S"]);
		_left = FlxG.keys.anyPressed(["LEFT", "A"]);
		_right = FlxG.keys.anyPressed(["RIGHT", "D"]);
		
		if (_up && _down)
			_up = _down = false;
		if (_left && _right)
			_left = _right = false;
		
		if ( _up || _down || _left || _right)
		{
			var mA:Float = 0;
			if (_up)
			{
				mA = -90;
				if (_left)
					mA -= 45;
				else if (_right)
					mA += 45;
					
				facing = FlxObject.UP;
			}
			else if (_down)
			{
				mA = 90;
				if (_left)
					mA += 45;
				else if (_right)
					mA -= 45;
				
				facing = FlxObject.DOWN;
			}
			else if (_left)
			{
				mA = 180;
				facing = FlxObject.LEFT;
			}
			else if (_right)
			{
				mA = 0;
				facing = FlxObject.RIGHT;
			}
			FlxAngle.rotatePoint(speed, 0, 0, 0, mA, velocity);
		}
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
	public function LevelUp(stat:String)
	{
		AddStat(stat);
		AddMaxLife(_HealthXLevel);
	}
	public function calculateFear():Void 
	{
		//DANIEL QUE ES ESTO??
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
	public function setStatus(statusName:String):Void 
	{
		var found:Bool = false;
		for (string in _status)
			if (string == statusName) found = true;
		
		if (found)
			_status.push(statusName);
			
		if (statusName == "Fear") _bonusDexterity += -Math.round(_bonusDexterity * 0.25);
		if (statusName == "Terrified") _bonusDexterity += -Math.round(_bonusDexterity * 0.50);
		if (statusName == "Hungry") _bonusStrenght += -Math.round(_bonusStrenght * 0.25);
		if (statusName == "Very Hungry") _bonusStrenght += -Math.round(_bonusStrenght * 0.50);
		if (statusName == "Tired") { _bonusDefense += -Math.round(_bonusDefense * 0.25); /*attackSpeed-*/}
		if (statusName == "Exhaust") {_bonusDefense += -Math.round(_bonusDefense * 0.50); /*attackSpeed--*/}
		if (statusName == "Slowed") { found = true; /*attackSpeed-*/ };

	}
	public function cureStatus(statusName:String):Bool
	{
		var removed:Bool = false;
		removed = _status.remove(statusName);
		if (removed) 
		{
			if (statusName == "Fear") _bonusDexterity += Math.round(_bonusDexterity * 0.25);
			if (statusName == "Terrified") _bonusDexterity += Math.round(_bonusDexterity * 0.50);
			if (statusName == "Hungry") _bonusStrenght += Math.round(_bonusStrenght * 0.25);
			if (statusName == "Very Hungry") _bonusStrenght += Math.round(_bonusStrenght * 0.50);
			if (statusName == "Tired") { _bonusDefense += Math.round(_bonusDefense * 0.25); /*attackSpeed+*/}
			if (statusName == "Exhaust") { _bonusDefense += Math.round(_bonusDefense * 0.50); /*attackSpeed++*/ }
			//if (statusName == "Poisoned") found = true;
			//if (statusName == "Stuned") found = true;
			//if (statusName == "Slowed") found = true;
			//if (statusName == "On Fire") found = true;
		}
		return removed;
	}
	
	override public function update():Void 
	{
		movement();
		super.update();
	}
}