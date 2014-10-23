package Items.Materials.Crafting ;
import Items.Item;

/**
 * ...
 * @author ...
 */
class BluePowder extends Item
{

	public function new() 
	{
		_itemName = "Blue Powder";
		
		_monsterDropRate = 20;
		_chestDropRate = 25;

		_sellPrice = 0;
		_buyPrice = 15;
		
	}
	
}