package enemy;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
 
class Node
{
	
	public var x:Int;
	public var y:Int;
	public var moveCost:Int;
	public var visited:Bool;
	public var nodeSum:Int;
	
	public function new() 
	{
		x = 0;
		y = 0;
		moveCost = 0;
		visited = false;
		nodeSum = 9;
	}
	
}