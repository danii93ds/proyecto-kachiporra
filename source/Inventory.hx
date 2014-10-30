package ;

import InventoryItem;
import items.Item;

/**
 * ...
 * @author ...
 */
 
class Inventory
{

	public var _matrix:Array<Array<InventoryItem>>;
	
	public function new() 
	{	
		_matrix = new Array<Array<InventoryItem>>();
		
		//for (i in 0...5) { _inventory[i] = []; _inventory[i][j] = null; }
		
		for (i in 0...5) for (j in 0...5) { _matrix[i][j] = new InventoryItem(); }
		
	}
	
}