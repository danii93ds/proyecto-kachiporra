package Items ;

/**
 * ...
 * @author ...
 */
abstract class Item
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
		return _ItemName;
	}
	
	public function itemNameSet(var name:String):String 
	{
		_itemName = name;
	}
	
	public function dropRateGet() {
		return _dropRate
	}
	
	public function dropRateSet(var value:Float):Float 
	{
		_dropRate = value;
	}
	
}