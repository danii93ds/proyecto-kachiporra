package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Juice extends Food
{

	public function new() 
	{
		_itemName = "Juice";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 10;
		_EnergyValue: 10;
	}
	
}