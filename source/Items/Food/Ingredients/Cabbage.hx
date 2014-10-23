package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Cabbage extends Food
{

	public function new() 
	{
		_itemName = "Cabbage";
		
		_monsterDropRate = 15;
		_chestDropRate = 25;

		_sellPrice = 0;
		_buyPrice = 30;
		
		_HealthValue: 5;
		_ArmorValue: 0;
		_HungryValue: 2;
		_EnergyValue: 0;
	}
	
}