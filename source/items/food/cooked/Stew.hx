package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Stew extends Food
{

	public function new(var soupHungry=Int) 
	{
		super();
		
		_itemName = "Stew";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue= 75;
		_ArmorValue= 0;
		_HungryValue= 50 + soupHungry;
		_EnergyValue= 0;		
	}
	
}