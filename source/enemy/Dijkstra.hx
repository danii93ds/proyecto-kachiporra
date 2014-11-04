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
	public var path:Vector<Node> = new Vector<Node>();
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
	
	public function FindMinNodePos():Point
	{
		var maxValue:Int = 999;
		var maxNodeIndex:Point = new Point(0,0);
		
		for (i in 0...cast room.width)
		{
			for (j in 0...cast room.height)
			{
				if (area[i][j].nodeSum <= maxValue && area[i][j].visited != true)
				{
					maxValue = area[i][j].nodeSum;
					maxNodeIndex.x = i;
					maxNodeIndex.y = j;
				}
			}
		}
		
		return maxNodeIndex;
	}
	
	//se llama dentro de set neighbours
	public function ChoosePath(_mWalls:FlxTilemap)
	{
		var target:Node = new Node();
		target.x = area[0][0].x;
		target.y = area[0][0].y;
		FlxG.log.add(area[0][0].x + " " + area[2][2].y + " target");
		
		//el nodo con el valor mas chico, es decir el que usamos
		area[3][1].nodeSum = 0;
		
		var index:Point;
		var i:Int;
		var j:Int;
		var outOfWhile:Bool = false;
		
		do {
			FlxG.log.add("entro a while");
			index = FindMinNodePos();
			i = cast index.x;
			j = cast index.y;
			//si arriba no hay pared
			if (_mWalls.getTile(area[i][j].x,area[i][j].y - 1) != 2)
			{
			//si se puede ir mas arriba
				if (i - 1 >= 0)
				{
					if (area[i][j].nodeSum + area[i - 1][j].moveCost <= area[i - 1][j].nodeSum && area[i - 1][j].visited != true)
					{
						area[i - 1][j].nodeSum = area[i][j].nodeSum + area[i - 1][j].moveCost;
						if (area[i - 1][j].x == target.x && area[i - 1][j].y == target.y)
							outOfWhile = true;
					}
				}
			}
			//si abajo no hay pared
			if (_mWalls.getTile(area[i][j].x,area[i][j].y + 1) != 2)
			{
			//si se puede ir mas abajo
				if (i + 1 >= 0)
				{
					if (area[i][j].nodeSum + area[i + 1][j].moveCost <= area[i + 1][j].nodeSum && area[i + 1][j].visited != true)
					{
						area[i + 1][j].nodeSum = area[i][j].nodeSum + area[i + 1][j].moveCost;
						if (area[i + 1][j].x == target.x && area[i + 1][j].y == target.y)
							outOfWhile = true;
					}
				}
			}
						
			//si izquierda no hay pared
			if (_mWalls.getTile(area[i][j].x + 1, area[i][j].y) != 2)
			{
				//si se puede ir mas izquierda
				if (j + 1 <= room.height)
				{
					if (area[i][j].nodeSum + area[i][j + 1].moveCost <= area[i][j + 1].nodeSum && area[i][j + 1].visited != true)
					{
						area[i][j + 1].nodeSum = area[i][j].nodeSum + area[i][j + 1].moveCost;
						if (area[i][j + 1].x == target.x && area[i][j + 1].y == target.y)
							outOfWhile = true;
					}	
				}
			}
			//si derecha no hay pared
			if (_mWalls.getTile(area[i][j].x - 1, area[i][j].y) != 2)
			{
				//si se puede ir mas derecha
				if (j - 1 <= room.height)
				{
					if (area[i][j].nodeSum + area[i][j - 1].moveCost <= area[i][j - 1].nodeSum && area[i][j - 1].visited != true)
					{
						area[i][j - 1].nodeSum = area[i][j].nodeSum + area[i][j - 1].moveCost;
						if (area[i][j - 1].x == target.x && area[i][j - 1].y == target.y)
							outOfWhile = true;
							
					}	
				}
			}
			area[i][j].visited = true;
			//path.push(area[i][j]);
			
			ShowLogValueMap();
			FlxG.log.add("salgo");
			FlxG.log.add(outOfWhile);
		}while (!outOfWhile);
		
		
	}
}