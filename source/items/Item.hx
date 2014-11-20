package items ;
import flixel.FlxSprite;

/**
 * ...
 * @author ...
 */
class Item extends FlxSprite
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
		super(0,0);
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