package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Rice extends Item
{

	public function new() 
	{
		_itemName = "Rice";
		
		_monsterDropRate = 15;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 60;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 0;
	}
	
}