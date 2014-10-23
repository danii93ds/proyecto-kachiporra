package items.food.ingredients ;
import items.Item;

/**
 * ...
 * @author ...
 */
class CoffeGrain extends Food
{

	public function new() 
	{
		_itemName = "Coffe Grain";
		
		_monsterDropRate = 25;
		_chestDropRate = 30;
		
		_sellPrice = 0;
		_buyPrice = 30;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 1;
	}
	
}