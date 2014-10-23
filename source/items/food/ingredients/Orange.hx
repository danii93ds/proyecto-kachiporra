package items.food.ingredients ;
import items.Item;
import items.food.Food;

/**
 * ...
 * @author ...
 */
class Orange extends Food
{

	public function new() 
	{
		_itemName = "Orange";
		
		_monsterDropRate = 20;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 35;
		
		_HealthValue: 10;
		_ArmorValue: 0;
		_HungryValue: 10;
		_EnergyValue: 0;
	}
	
}