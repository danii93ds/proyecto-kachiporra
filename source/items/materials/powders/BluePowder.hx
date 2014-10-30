package items.materials.powders ;
import items.Item;

/**
 * ...
 * @author ...
 */
class BluePowder extends Item
{

	public function new() 
	{
		super();
		
		_itemName = "Blue Powder";
		
		_monsterDropRate = 20;
		_chestDropRate = 25;

		_sellPrice = 0;
		_buyPrice = 15;		
		
	}
	
}