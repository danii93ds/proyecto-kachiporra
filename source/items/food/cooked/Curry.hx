package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Curry extends Food
{

	public function new() 
	{
		super();
		
		_itemName = "Curry";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue = 40;
		_ArmorValue = 0;
		_HungryValue = 50;
		_EnergyValue = 0;
	}
	
}