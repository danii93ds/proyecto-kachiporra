package enemy ;
import flixel.tile.FlxTilemap;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import flixel.FlxG;
import openfl.Vector;
/**
 * ...
 * @author ...
 */

class Dijkstra
{
	public var area:Array<Array<Node>>;
	public var path:Vector<Node>;
	public var pathSum:Int = 0;
	public var room:Rectangle;
	
	public function new(_room:Rectangle,_mWalls:FlxTilemap) 
	{
		room = _room;
		var startX = Std.int(room.x);
		var startY = Std.int(room.y);
		var destX = Std.int(room.width) + startX;
		var destY = Std.int(room.height) + startY;
		var heightIndex:Int = 0;
		var widthIndex:Int = 0;
		var nsfng:Node;
		
		
		area = {[for (x in 0...cast room.width) [for (y in 0...cast room.height) new Node()]];}
		
		for (i in startX...destX)
		{
			for (j in startY...destY)
			{
				var tempValue:Int = _mWalls.getTile(i, j);	
				area[widthIndex][heightIndex].moveCost = tempValue;
				area[widthIndex][heightIndex].x = i;
				area[widthIndex][heightIndex].y = j;
				heightIndex++;
			}
			widthIndex++;
			heightIndex = 0;
		}
			

		ChoosePath(_mWalls);
		ShowLogValueMap();
	}
	
	
	public function ShowLogValueMap()
	{
		//ver el cuarto en valores
		var string:String = " ";
		for (array in area)
		{
			for (node in array)
			{
				string = string + node.nodeSum + "   ";
			}
			FlxG.log.add(string);
			string = " ";
		}
	}
	
	public function SetNeighbours(enemyPos:Point,_mWalls:FlxTilemap)
	{
		var tempNode:Node = new Node();
		var i:Int = 0;
		var j:Int = 0;
		
		for (array in area)
		{
			for (node in array)
			{
				if (node.x == enemyPos.x && node.y == enemyPos.y)
				{
					node.nodeSum = 0;
				}
				j++;
			}
			i++;
		}
	}
	
	//se llama dentro de set neighbours
	public function ChoosePath(_mWalls:FlxTilemap)
	{
		path = new Vector<Node>();
		var target:Node;
		var currentNode:Node = new Node();
		//el nodo con el valor mas chico, es decir el que usamos
		area[0][0].nodeSum = 0;
		
		
		for (i in 0...cast room.width)
		{
			for (j in 0...cast room.height)
			{
				
				if (currentNode.nodeSum >= area[i][j].nodeSum && area[i][j].visited != true)
				{
					currentNode = area[i][j];
					
					//si arriba no hay pared
					if (_mWalls.getTile(currentNode.x,currentNode.y - 1) != 2)
					{
						//si se puede ir mas arriba
						if (i - 1 >= 0)
						{
							if (currentNode.nodeSum + area[i - 1][j].moveCost <= area[i - 1][j].nodeSum)
								area[i - 1][j].nodeSum = currentNode.nodeSum + area[i - 1][j].moveCost;
						}
							
					}
					//si abajo no hay pared
					if (_mWalls.getTile(currentNode.x, currentNode.y + 1) != 2)
					{
						//si se puede ir mas abajo
						if (i + 1 <= room.width)
						{
							if (currentNode.nodeSum + area[i + 1][j].moveCost <= area[i + 1][j].nodeSum)
								area[i + 1][j].nodeSum = currentNode.nodeSum + area[i + 1][j].moveCost;
						}
					}
					//si izquierda no hay pared
					if (_mWalls.getTile(currentNode.x + 1, currentNode.y) != 2)
					{
						//si se puede ir mas izquierda
						if (j + 1 <= 0)
						{
							if (currentNode.nodeSum + area[i][j + 1].moveCost <= area[i][j + 1].nodeSum)
								area[i][j + 1].nodeSum = currentNode.nodeSum + area[i][j + 1].moveCost;
						}
					}
					//si derecha no hay pared
					if (_mWalls.getTile(currentNode.x - 1, currentNode.y) != 2)
					{
						//si se puede ir mas derecha
						if (j - 1 >= 0)
						{
							if (currentNode.nodeSum + area[i][j - 1].moveCost <= area[i][j - 1].nodeSum)
								area[i][j - 1].nodeSum = currentNode.nodeSum + area[i][j - 1].moveCost;
								FlxG.log.add(area[i][j - 1].nodeSum);
						}
					}
					
					currentNode.visited = true;
					path.push(currentNode);
				
				}
			}
		}
		
	}
}