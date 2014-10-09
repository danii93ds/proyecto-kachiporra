package Items.Food.Cooked;
import Items.Food.Ingredients.Food;

/**
 * ...
 * @author ...
 */
class Meat extends Item
{

	public function new() 
	{
		_itemName = "Meat";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 30;
		_ArmorValue: 0;
		_HungryValue: 25;
		_EnergyValue: 0;
	}
	
}