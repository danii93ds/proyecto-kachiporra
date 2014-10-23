package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Soup extends Food
{

	public function new(var vegetablesCount:Int) 
	{
		_itemName = "Soup";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 75;
		_ArmorValue: 0;
		_HungryValue: 5 + (vegetablesCount * 10);
		_EnergyValue: 0;		
	}
	
}