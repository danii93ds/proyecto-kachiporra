package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class CoffeDrink extends Item
{

	
	public function new() 
	{
		_itemName = "Coffe Drink";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 15;
	}
	
}