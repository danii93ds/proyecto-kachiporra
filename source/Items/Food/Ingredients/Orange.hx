package Items.Food.Ingredients ;
import Items.Food.Food;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Orange extends Food
{

	public function new() 
	{
		_itemName = "Orange";
		
		_monsterDropRate = 20;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 35;
		
		_HealthValue: 10;
		_ArmorValue: 0;
		_HungryValue: 10;
		_EnergyValue: 0;
	}
	
}