package items.food.cooked;
import items.Item;

/**
 * ...
 * @author ...
 */
class Sandwich2 extends Food 
{

	public function new() 
	{
		super();
		
		_itemName = "Sandwich+";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue= 75;
		_ArmorValue= 0;
		_HungryValue= 60;
		_EnergyValue= 0;
	}
	
}