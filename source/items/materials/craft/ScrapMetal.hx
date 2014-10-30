package items.materials.craft;
import items.materials.Material;

/**
 * ...
 * @author ...
 */
class ScrapMetal extends Material
{

	public function new() 
	{
		super();
		
		_itemName = "Scrap Metal";
		
		_monsterDropRate = 40;
		_chestDropRate = 50;
		
		_sellPrice = 0;
		_buyPrice = 25;
		
	}
	
}