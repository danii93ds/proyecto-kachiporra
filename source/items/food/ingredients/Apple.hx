package items.food.ingredients ;
import items.Item;

/**
 * ...
 * @author ...
 */
class Apple extends Food
{

	public function new() 
	{
		super();
		
		_itemName = "Apple";
		
		_monsterDropRate = 20;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 35;
		
		_HealthValue= 10;
		_ArmorValue= 0;
		_HungryValue= 10;
		_EnergyValue= 5;
	}
	
}