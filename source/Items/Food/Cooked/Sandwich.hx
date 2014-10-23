package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Sandwich extends Food
{

	public function new() 
	{
		_itemName = "Sandwich";
		
		_monsterDropRate = 0;
		_chestDropRate = 0;
		
		_sellPrice = 0;
		_buyPrice = 0;
		
		_HealthValue: 50;
		_ArmorValue: 0;
		_HungryValue: 35;
		_EnergyValue: 0;
	}
	
}