package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class CoffeDrink extends Food
{

	
	public function new() 
	{
		super();
		
		_itemName = "Coffe Drink";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue = 0;
		_ArmorValue = 0;
		_HungryValue = 0;
		_EnergyValue = 15;
	}
	
}