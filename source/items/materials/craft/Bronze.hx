package items.materials.craft ;
import items.Item;
import items.materials.Material;

/**
 * ...
 * @author ...
 */
class Bronze extends Material
{

	public function new() 
	{
		super();
		
		_itemName = "Bronze";
		
		_monsterDropRate = 0;
		_chestDropRate = 70;

		_sellPrice = 0;
		_buyPrice = 30;
		
	}
	
}