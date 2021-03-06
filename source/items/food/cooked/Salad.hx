package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Salad extends Food
{
	
	public function new(var vegetablesCount=Int) 
	{
		super();
		
		_itemName = "Salad";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue= 25 ;
		_ArmorValue= 0;
		_HungryValue= 5 + (vegetablesCount* 5);
		_EnergyValue= 0;
	}
	
}