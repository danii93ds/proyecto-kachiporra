package ;
import flash.utils.CompressionAlgorithm;
import flixel.FlxSprite;
import openfl.Vector;
import Status;
import flixel.util.FlxRandom;


/**
 * ...
 * @author ...
 */
 
class Player extends FlxSprite
{
	
	private var _posX:Int;
	private var _posY:Int;
	
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

	public function new() 
	{
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
		
	public function setStatus(statusName:String):Void {
		Bool found = false;
		for (status in _status)
			if (status.getName == statusName) found = true;
		
		if (!found) {
			var newStatus:Status = new Status(statusName, -1);
			
			if (statusName == "Slowed") { found = true; /*attackSpeed-*/ };
			if (statusName == "Stuned") newStatus.setTurns = 2;
			if (statusName == "Poisoned") newStatus.setTurns = 5;
			if (statusName == "OnFire") newStatus.setTurns = 3;
			
			_status.push(newStatus);
		}

	}
	
	public function cureStatus(statusName:String):Void {
		var removed:Bool = false;
		var removed:Bool = false;
		var statusFound:Status;
		for (status in _status){
			if (status.getName == statusName) {
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
			if (status.getName == "Poisoned") _currentHealth -= Math.round(_healthBase * 0.02); // 10% x 5 turns
			if (status.getName == "On Fire") _currentHealth -= Math.round(_HealthBase * 0.05); //  15% x 3 turns
			status.setTurns(status.getTurns() - 1);
			if (status.getTurns() <= 0) cureStatus(status.getName());
		}
	
	public function attack():Int {
		return FlxRandom.intRanged(_DamageMin + (_Strength * 0.8), _DamageMax + (_Strength * 1.2));
	}
		
}