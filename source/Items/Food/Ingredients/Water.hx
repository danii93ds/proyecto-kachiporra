package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Water extends Item
{

	public function new() 
	{
		_itemName = "Water";
		
		_monsterDropRate = 60;
		_chestDropRate = 40;
		
		_sellPrice = 0;
		_buyPrice = 25;
		
		_HealthValue: 5;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 0;
	}
	
}