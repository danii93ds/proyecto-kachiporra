package map;
import items.food.ingredients.Potato;
import openfl.geom.Point;
import openfl.Vector;
import openfl.geom.Rectangle;
import flixel.util.FlxRandom;
/**
 * ...
 * @author ...
 */
class MapDistribution
{
	public var playerStartPos:Point;
	public var entrancePos:Point;
	public var exitPos:Point;
	public var enemySpawn:Vector<Point>;
	
	public var tileSize:Int = 16;
	
	public function new(allRooms:Vector<Rectangle>) 
	{
		//set entrance position
		entrancePos = new Point(0, 0);
		if (allRooms[0].width % 2 != 0)
			entrancePos.x = allRooms[0].x * tileSize + (allRooms[0].width * tileSize) / 2 + (tileSize / 2);
		else
			entrancePos.x = allRooms[0].x * tileSize + (allRooms[0].width * tileSize) / 2 - tileSize;
		if (allRooms[0].height % 2 != 0)
			entrancePos.y = allRooms[0].y * tileSize + (allRooms[0].height * tileSize) / 2 + (tileSize / 2);
		else
			entrancePos.y = allRooms[0].y * tileSize + (allRooms[0].height * tileSize) / 2;
		
		//set player position
		playerStartPos = new Point(0, 0);
		playerStartPos.x = entrancePos.x;
		playerStartPos.y = entrancePos.y;
		
		//set exit pos
		exitPos = new Point(0,0);
		exitPos.x = allRooms[allRooms.length - 1].x * tileSize + (allRooms[allRooms.length - 1].width * tileSize) / 2;
		exitPos.y = allRooms[allRooms.length - 1].y * tileSize + (allRooms[allRooms.length - 1].height * tileSize - tileSize);
		
		//set enemy positions
		enemySpawn = new Vector<Point>();
		for (room in allRooms)
		{
			//para que no spawneen en el primer cuarto
			if(room != allRooms[0])
				enemySpawn.push(EnemySpawnPos(room));
		}
	}
	
	public function EnemySpawnPos(room:Rectangle):Point
	{
		var punto:Point = new Point();
		var startX = Std.int(room.x);
		var startY = Std.int(room.y);
		var destX = Std.int(room.width) + startX;
		var destY = Std.int(room.height) + startY;
		
		punto.x = cast FlxRandom.intRanged(startX * tileSize,(destX * tileSize - tileSize)) ;
		punto.y = cast FlxRandom.intRanged(startY * tileSize,(destY * tileSize - tileSize));
		return punto;
	}
	
}