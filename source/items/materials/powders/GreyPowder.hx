package items.materials.powders ;
import items.Item;

/**
 * ...
 * @author ...
 */
class GreyPowder extends Item 
{

	public function new() 
	{
		super();
		
		_itemName = "Grey Powder";
		
		_monsterDropRate = 40;
		_chestDropRate = 50;
		
		_sellPrice = 0;
		_buyPrice = 25;
		
	}
	
}