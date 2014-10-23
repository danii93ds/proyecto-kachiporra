package Items.Materials.Crafting ;
import Items.Item;

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

	}
	
}