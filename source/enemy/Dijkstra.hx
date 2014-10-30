package enemy ;
import enemy.Node;
import flixel.tile.FlxTilemap;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import flixel.FlxG;
/**
 * ...
 * @author ...
 */

class Dijkstra
{
	public var area:Array<Array<Node>>;
	public var path:Array<Point>;
	public var visited:Array<Node>;
	public var tempValue:Int;
	
	public function new(room:Rectangle,_mWalls:FlxTilemap) 
	{
		var startX = Std.int(room.x);
		var startY = Std.int(room.y);
		var destX = Std.int(room.width) + startX;
		var destY = Std.int(room.height) + startY;
		var heightIndex:Int = 0;
		var widthIndex:Int = 0;
		var nullNode:Node = new Node();
		
		area = {[for (x in 0...cast room.width) [for (y in 0...cast room.height) nullNode]];}
		
		for (i in startX...destX)
		{
			for (j in startY...destY)
			{
				tempValue = _mWalls.getTile(i, j);	
				area[widthIndex][heightIndex].moveCost = tempValue;
				heightIndex++;
			}
			widthIndex++;
			heightIndex = 0;
		}
		//ver el cuarto en valores
		var string:String = " ";
		for (array in area)
		{
			for (node in array)
				string = string + node.moveCost;
			FlxG.log.add(string);
			string = " ";
		}
			
			
			
			
	}
	
}