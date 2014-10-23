package Items.Materials.Powder ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class RedPowder extends Item
{

	public function new() 
	{
		_itemName = "Red Powder";
		
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