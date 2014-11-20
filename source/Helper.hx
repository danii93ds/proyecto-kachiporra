package  ;

/**
 * ...
 * @author ...
 */

import enemy.Enemy;
import flixel.util.FlxPoint;
import flixel.group.FlxTypedGroup;
import flixel.FlxG;
 
enum MoveDirection
{
	UP;
	DOWN;
	LEFT;
	RIGHT;
}
 
 
class Helper
{
	private static var playState:PlayState;
	
	static public function setPlayState(pS:PlayState) {
		playState = pS;
	}
	
	static public function danyCast(player:Player,playerPos:FlxPoint, toGoPos:FlxPoint, damage:Int, _enemies:FlxTypedGroup<Enemy>, moveDirection:MoveDirection):Bool {
		for (enemy in _enemies) {
			
			if (moveDirection == cast MoveDirection.UP ) {
				if ( (enemy.y >= toGoPos.y && enemy.y <= playerPos.y) && (enemy.x == playerPos.x) ){
					enemy.getDamage(damage);
					enemy.Die(player, playState);
					FlxG.log.add(damage + " Damage done");
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.DOWN) {
				if ( (enemy.y <= toGoPos.y && enemy.y >= playerPos.y) && (enemy.x == playerPos.x) ){
					enemy.getDamage(damage);
					enemy.Die(player, playState);
					FlxG.log.add(damage + " Damage done");
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.LEFT) {
				if ( (enemy.x >= toGoPos.x && enemy.x <= playerPos.x) && (enemy.y == playerPos.y) ){
					enemy.getDamage(damage);
					enemy.Die(player, playState);
					FlxG.log.add(damage + " Damage done");
					return true;
				}
			}
			if (moveDirection == cast MoveDirection.RIGHT){
				if ( (enemy.x <= toGoPos.x && enemy.x >= playerPos.x) && (enemy.y == playerPos.y) ){
					enemy.getDamage(damage);
					enemy.Die(player, playState);
					FlxG.log.add(damage + " Damage done");
					return true;
				}
			}
		}
		return false;
	}
	
}