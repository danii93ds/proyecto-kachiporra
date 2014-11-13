package  ;

/**
 * ...
 * @author ...
 */

import enemy.Enemy;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
 
enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}
 
 
class Helper
{
	
	function new (){}
	
	static public function danyCast(playerPos:FlxPoint, toGoPos:FlxPoint, damage:Int, _enemies:FlxTypedGroup<Enemy>, moveDirection:MoveDirection):Bool {
		for (enemy in _enemies) {
			
			if (moveDirection == cast MoveDirection.UP ) {
				if ( (enemy.y >= toGoPos.y && enemy.y <= playerPos.y) && (enemy.x == playerPos.x) ){
					enemy.getDamage(damage);
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.DOWN) {
				if ( (enemy.y <= toGoPos.y && enemy.y >= playerPos.y) && (enemy.x == playerPos.x) ){
					enemy.getDamage(damage);
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.LEFT) {
				if ( (enemy.x >= toGoPos.x && enemy.x <= playerPos.x) && (enemy.y == playerPos.y) ){
					enemy.getDamage(damage);
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.RIGHT){
				if ( (enemy.x <= toGoPos.x && enemy.x >= playerPos.x) && (enemy.y == playerPos.y) ){
					enemy.getDamage(damage);
					return true;
				}
			}
		}
		return false;
	}
	
}