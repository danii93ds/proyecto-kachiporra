package items.combat.bullets;
import items.Item;

/**
 * ...
 * @author ...
 */
class PoisonBullet extends Item
{

	public function new() 
	{
		super();
		
		_itemName = "Poison Bullet";
		
		_monsterDropRate = 0;
		_chestDropRate = 10;
		
		_sellPrice = 0;
		_buyPrice = 0;
	}
	
}