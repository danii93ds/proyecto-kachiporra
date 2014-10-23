package items.combat;
import items.Equipment;

/**
 * ...
 * @author ...
 */
class Sword extends Equipment
{

	private var _swordDamageMin:Int;
	private var _swordDamageMax:Int;
	
	
	public function new() 
	{
		super();
		
		_Name = "Sword";
		//Damage
		_swordDamageMin = 2;
		_swordDamageMax = 5;
		
		_Level = 0;
		
	}
	
	public function MinDamage():Int {
		return _swordDamageMin;
	}
	
	public function MaxDamage():Int {
		return _swordDamageMax;
	}
	
}