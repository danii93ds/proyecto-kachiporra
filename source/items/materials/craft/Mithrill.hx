package items.materials.craft ;
import items.Item;
import items.materials.Material;

/**
 * ...
 * @author ...
 */
class Mithrill extends Material
{

	public function new() 
	{
		super();
		
		_itemName = "Mithrill";
		
		_monsterDropRate = 0;
		_chestDropRate = 30;
		
		_sellPrice = 0;
		_buyPrice = 70;
		
	}
	
}