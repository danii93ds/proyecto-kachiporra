package enemy ;
import flixel.tile.FlxTilemap;
import flixel.util.FlxPoint;
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
	public var room:Rectangle;
	public var moveMap:FlxTilemap;
	
	public function new(_room:Rectangle,_mWalls:FlxTilemap) 
	{
		room = _room;
		var startX = Std.int(room.x);
		var startY = Std.int(room.y);
		var destX = Std.int(room.width) + startX;
		var destY = Std.int(room.height) + startY;
		var heightIndex:Int = 0;
		var widthIndex:Int = 0;
		
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
	public function ChoosePath(_mWalls:FlxTilemap,_target:Player,startPos:FlxPoint):Vector<Node>
	{
		var target:Node = new Node();
		var couldPath:Vector<Node> = new Vector<Node>();
		var realPath:Vector<Node> = new Vector<Node>();
		
		moveMap = _mWalls;
		
		for (array in area)
		{
			for (node in array)
			{	
				if (node.x == startPos.x && node.y == startPos.y)
				{
					FlxG.log.add(startPos.x + " " + startPos.y + " pos");
					node.nodeSum = 0;
				}
				
				if (node.x == Std.int(_target.x / 16)  && node.y ==Std.int( _target.y / 16) )
				{
					FlxG.log.add(Std.int(_target.x / 16) + " " + Std.int( _target.y / 16) + " target");
					target = node;
				}
			}
		}
		var preD:Node = target;
		
		//el nodo con el valor mas chico, es decir el que usamos
		
		var index:Point = new Point();
		var i:Int;
		var j:Int;
		var outOfWhile:Bool = false;
		
		do {
			index = FindMinNodePos();
			i = cast index.x;
			j = cast index.y;
			//meto el nodo en path
			couldPath.push(area[i][j]);
			
			//si derecha no hay pared
			if (_mWalls.getTile(area[i][j].x - 1,area[i][j].y) > 6)
			{
			//si se puede ir mas derecha
				if (i - 1 >= 0)
				{
					if (area[i][j].nodeSum + area[i - 1][j].moveCost <= area[i - 1][j].nodeSum && area[i - 1][j].visited != true)
					{
						area[i - 1][j].nodeSum = area[i][j].nodeSum + area[i - 1][j].moveCost;
						if (area[i - 1][j].x == target.x && area[i - 1][j].y == target.y)
						{
							couldPath.push(area[i - 1][j]);
							outOfWhile = true;
						}
					}
				}
			}
			
			//si izquierda no hay pared
			if (_mWalls.getTile(area[i][j].x + 1,area[i][j].y) > 6)
			{
			//si se puede ir mas izquierda
				if (i + 1 < room.width)
				{
					if (area[i][j].nodeSum + area[i + 1][j].moveCost <= area[i + 1][j].nodeSum && area[i + 1][j].visited != true)
					{
						area[i + 1][j].nodeSum = area[i][j].nodeSum + area[i + 1][j].moveCost;
						if (area[i + 1][j].x == target.x && area[i + 1][j].y == target.y)
						{
							couldPath.push(area[i + 1][j]);
							outOfWhile = true;
						}
					}
				}
			}
					
			//si abajo no hay pared
			if (_mWalls.getTile(area[i][j].x, area[i][j].y + 1) > 6)
			{
				//si se puede ir mas abajo
				if (j + 1 < room.height)
				{
					if (area[i][j].nodeSum + area[i][j + 1].moveCost <= area[i][j + 1].nodeSum && area[i][j + 1].visited != true)
					{
						area[i][j + 1].nodeSum = area[i][j].nodeSum + area[i][j + 1].moveCost;
						if (area[i][j + 1].x == target.x && area[i][j + 1].y == target.y)
						{
							couldPath.push(area[i][j + 1]);
							outOfWhile = true;
						}
					}	
				}
			}
			
			//si arriba no hay pared
			if (_mWalls.getTile(area[i][j].x, area[i][j].y - 1) > 6)
			{
				//si se puede ir mas arriba
				if (j - 1 >= 0)
				{
					if (area[i][j].nodeSum + area[i][j - 1].moveCost <= area[i][j - 1].nodeSum && area[i][j - 1].visited != true)
					{
						area[i][j - 1].nodeSum = area[i][j].nodeSum + area[i][j - 1].moveCost;
						if (area[i][j - 1].x == target.x && area[i][j - 1].y == target.y)
						{
							couldPath.push(area[i][j - 1]);
							outOfWhile = true;
						}	
					}	
				}
			}
			area[i][j].visited = true;

		
		}while (!outOfWhile);
	
		FlxG.log.add("hola");
		//guarda el path (esta invertido)
		realPath.push(target); // empieza desde el target y va para atras
		do{
			for (node in couldPath)
			{
				if (node.nodeSum < preD.nodeSum)
				{
					//si a la izquierda no hay pared
					if (node.x + 1 == preD.x && node.y == preD.y)
					{
						realPath.push(node);
						preD = node;
						//si a la dercha no hay pared
					}else if(node.x - 1 == preD.x && node.y == preD.y)
					{
						realPath.push(node);
						preD = node;
						//si abajo no hay pared
					}else if(node.x == preD.x && node.y + 1 == preD.y)
					{
						realPath.push(node);
						preD = node;
						//si arriba no hay pared
					}else if(node.x == preD.x && node.y - 1 == preD.y)
					{
						realPath.push(node);
						preD = node;
					}
				}
			}
		}while (preD.nodeSum != 0);
		
		return realPath;
	}
}