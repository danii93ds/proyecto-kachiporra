package items.food.ingredients ;
import items.Item;
import items.food.Food;

/**
 * ...
 * @author ...
 */
class Water extends Food
{

	public function new() 
	{
		_itemName = "Water";
		
		_monsterDropRate = 60;
		_chestDropRate = 40;
		
		_sellPrice = 0;
		_buyPrice = 25;
		
		_HealthValue: 5;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 0;
	}
	
}