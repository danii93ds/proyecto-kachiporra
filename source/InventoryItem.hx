package ;
import items.Item;

/**
 * ...
 * @author ...
 */
class InventoryItem
{

	private var _item:Item;
	private var _count:UInt;
	
	public function new(item:Item) 
	{
		_count = 0;
	}
	
	public function setItem(item:Item)
	{
		_item = item;
	}
	
	public function getItem():Item 
	{
		return _item;
	}
	
	public function getCount():UInt 
	{
		return _count;
	}
	
	public function setCount(cant:Int)
	{
		if (cant > 0 || _count > cant)
			_count += cant;
	}
	
}