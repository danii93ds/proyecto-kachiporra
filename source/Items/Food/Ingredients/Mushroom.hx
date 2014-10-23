package Items.Food.Ingredients ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class Mushroom extends Food
{

	public function new() 
	{
		_itemName = "Mushroom";
		
		_monsterDropRate = 10;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 60;
		
		_HealthValue: 5;
		_ArmorValue: 0;
		_HungryValue: 2;
		_EnergyValue: 0;
	}
	
}