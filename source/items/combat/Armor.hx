package items.combat;
import items.Equipment;

/**
 * ...
 * @author ...
 */
class Armor extends Equipment
{
	
	private var _Defense:Int;

	public function new() 
	{
		super();
		
		_Name = "Armor";
		_Defense = 5;
		
		_Level = 0;
	}
	
	public function Defense():Int {
		return _Defense;
	}
	
	public function Craft() {
		
	}
	
}