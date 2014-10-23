package items.food.ingredients ;
import items.Item;

/**
 * ...
 * @author ...
 */
class Cheese extends Food 
{

	public function new() 
	{
		_itemName = "Cheese";
		
		_monsterDropRate = 40;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 50;
		
		_HealthValue: 10;
		_ArmorValue: 0;
		_HungryValue: 5;
		_EnergyValue: 0;
	}
	
}