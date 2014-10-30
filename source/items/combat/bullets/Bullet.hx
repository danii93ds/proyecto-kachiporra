package items.combat.bullets;

/**
 * ...
 * @author ...
 */
class Bullet extends Item
{

	public function new() 
	{
		super();
		
		_itemName = "Bullet";
		
		_monsterDropRate = 0;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 0;
	}
	
}