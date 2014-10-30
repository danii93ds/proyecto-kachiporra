package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Meat extends Food
{

	public function new() 
	{
		super();
		
		_itemName = "Meat";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue= 30;
		_ArmorValue= 0;
		_HungryValue= 25;
		_EnergyValue= 0;
	}
	
}