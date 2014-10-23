package items.combat;
import items.Equipment;

/**
 * ...
 * @author ...
 */
class Gun extends Equipment
{
	
	private var _gunDamageMin:Int;
	private var _gunDamageMax:Int;
		
	public function new() 
	{
		super();
		
		_Name = "Gun";
		
		_gunDamageMin = 4;
		_gunDamageMax = 7;
		
		_Level = 0;
		
	}
	
	public function MinDamage():Int {
		return _gunDamageMin;
	}
	
	public function MaxDamage():Int {
		return _gunDamageMax;
	}
	
}