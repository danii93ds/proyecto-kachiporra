package ;
import flash.geom.Rectangle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxAngle;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;
import flixel.util.FlxRandom;
import openfl.geom.Point;
import openfl.Vector;
import flash.display.IBitmapDrawable;
import flash.display.DisplayObject;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import Leaf;

/**
 * ...
 * @author ...
 */
class BSPgenerator
{
	public var MAX_LEAF_SIZE:Int = 20;
	public var _leafs:Vector<Leaf> = new Vector<Leaf>();
	private var _map:FlxOgmoLoader;
	
	
	public function new() 
	{
		
	}
	
	public function CreateLeafs()
	{
		_map = new FlxOgmoLoader("assets/data/basic.oel");
		var temp:Vector<Leaf> = new Vector<Leaf>();
		// first, create a Leaf to be the 'root' of all Leafs.
		var root:Leaf = new Leaf(0, 0,cast _map.width/16 - 2,cast _map.height/16 - 2);//los -2 son para que no haya piso en los bordes del mapa
		_leafs.push(root);
		
		var did_split:Bool = true;
		// we loop through every Leaf in our Vector over and over again, until no more Leafs can be split.
		
		while (did_split)
		{
			did_split = false;
			for(l in _leafs)
			{
				if (l.leftChild == null && l.rightChild == null) // if this Leaf is not already split...
				{
					// if this Leaf is too big, or 75% chance...
					if (l.width > MAX_LEAF_SIZE || l.height > MAX_LEAF_SIZE || FlxRandom.int() > 0.25)
					{
						if (l.split()) // split the Leaf!
						{
							// if we did split, push the child leafs to the Vector so we can loop into them next
							_leafs.push(l.leftChild);
							_leafs.push(l.rightChild);
							did_split = true;
						}
					}
				}
			}
		}
		
		
		// next, iterate through each Leaf and create a room in each one.
		root.createRooms();
		
	}
	
	
}