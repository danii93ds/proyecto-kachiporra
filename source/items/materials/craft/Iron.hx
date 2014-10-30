package items.materials.craft;
import items.Item;
import items.materials.Material;

/**
 * ...
 * @author ...
 */
class Iron extends Material
{

	public function new() 
	{
		super();
		
		_itemName = "Iron";
		
		_monsterDropRate = 0;
		_chestDropRate = 50;
		
		_sellPrice = 0;
		_buyPrice = 45;
		
	}
	
}