package items.materials.powders ;
import items.Item;

/**
 * ...
 * @author ...
 */
class RedPowder extends Item
{

	public function new() 
	{
		super();
		
		_itemName = "Red Powder";
		
		_monsterDropRate = 20;
		_chestDropRate = 25;
		
		_sellPrice = 0;
		_buyPrice = 15;

	}
	
}