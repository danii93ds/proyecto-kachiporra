package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Curry extends Item
{

	public function new() 
	{
		_itemName = "Curry";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 40;
		_ArmorValue: 0;
		_HungryValue: 50;
		_EnergyValue: 0;
	}
	
}