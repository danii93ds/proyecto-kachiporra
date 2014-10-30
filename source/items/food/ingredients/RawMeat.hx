package items.food.ingredients ;
import items.Item;

/**
 * ...
 * @author ...
 */
class RawMeat extends Food
{

	public function new() 
	{
		super();
		
		_itemName = "Raw Meat";
		
		_monsterDropRate = 60;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue= 20;
		_ArmorValue= 0;
		_HungryValue= -10;
		_EnergyValue= 0;
	}
	
}