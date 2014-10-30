package items.combat.bullets;
import items.Item;

/**
 * ...
 * @author ...
 */
class FireBullet extends Item
{

	public function new() 
	{
		super();
		
		_itemName = "Fire Bullet";
		
		_monsterDropRate = 0;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 0;
	}
	
}