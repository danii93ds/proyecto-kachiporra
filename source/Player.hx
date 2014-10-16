package ;
import flash.utils.CompressionAlgorithm;
import flixel.FlxSprite;
import haxe.ds.Vector;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	
	private var _x:Int;
	private var _y:Int;
	
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

	public function new() 
	{
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
	
	private function AddMaxLife(int health) {
		_healthBase += health;
	}
	
	private function AddStat(String stat):Void { 
		
		switch stat 
		{
			case "Strenght":
				_Strength++;
				break;
			case "Defense":
				_Defense++;
				break;
			case "Dexterity":
				_Dexterity++;
				break;
		}
	}
	
	public function LevelUp(String stat) {
		AddStat(stat);
		AddMaxLife(_HealthXLevel);
	}
		
	public function calculateFear():Void {
		if (false) //tileVisibility Dark
			_Fear -= 2;
		else if (false) // tileVisibility Light
			_Fear + 2;
			
		//tileVisibility MidLight
	}
		
	public function setHungry():Void {
		_Hungry -= 3;
	}
	
	public function eat(Int foodValue) {
		_Hungry += foodValue;
		if (_Hungry > 100) _Hungry = 100;
	}
		
	public function tireEnergy():Void {
		_Energy--;
	}
	
	public function sleep():Void {
		_Energy = 100;
	}
	
	public function setStatus(String statusName):Void {
		Bool found = false;
		for (string in _status)
			if (strintg == statusName) found = true;
		
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
	
	public function cureStatus(String statusName):Bool {
		Bool removed = false;
		removed = _status.remove(statusName);
		if (removed) {
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
	}
	
}