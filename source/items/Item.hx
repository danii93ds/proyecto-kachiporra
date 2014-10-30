package items ;

/**
 * ...
 * @author ...
 */
class Item
{
	//Type
	private var _itemName:String;
	
	//Drop Rate
	private var _monsterDropRate:Int;
	private var _chestDropRate:Int;
	
	//Shop
	private var _sellPrice:Int;
	private var _buyPrice:Int;
	
	private var _itemType:String;
	
	public function new() 
	{
		
	}
	
	public function ItemNameGet()
	{
		return _itemName;
	}
	
	public function itemNameSet(name:String)
	{
		_itemName = name;
	}

}