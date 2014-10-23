package Items.Materials.Powder ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class GreyPowder extends Item 
{

	public function new() 
	{
		_itemName = "Grey Powder";
		
		_monsterDropRate = 40;
		_chestDropRate = 50;
		
		_sellPrice = 0;
		_buyPrice = 25;
		
		_HealthValue: 0;
		_ArmorValue: 0;
		_HungryValue: 0;
		_EnergyValue: 0;
	}
	
}