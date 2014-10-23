package items.food.ingredients ;
import items.Item;

/**
 * ...
 * @author ...
 */
class Bread extends Food
{

	public function new() 
	{
		_itemName = "Bread";
		
		_monsterDropRate = 40;
		_chestDropRate = 40;
		
		_sellPrice = 50;
		_buyPrice = 0;
		
		_HealthValue: 20;
		_ArmorValue: 0;
		_HungryValue: 5;
		_EnergyValue: 0;
	}
	
}