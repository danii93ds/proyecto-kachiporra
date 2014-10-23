package items.materials.powders ;
import items.Item;

/**
 * ...
 * @author ...
 */
class YellowPowder extends Item
{

	public function new() 
	{
		_itemName = "Yellow Powder";
		
		_monsterDropRate = 20;
		_chestDropRate = 25;
		
		_sellPrice = 0;
		_buyPrice = 15;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 0;
	}
	
}