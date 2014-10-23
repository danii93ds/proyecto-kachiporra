package map ;
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

/**
 * ...
 * @author ...
 */
class Leaf
{
	// the position and size of this Leaf
	public var y:Int;
	public var x:Int;
	public var width:Int;
	public var height:Int; 
	public var MIN_LEAF_SIZE:Int = 6;
	
	
	public var leftChild:Leaf; // the Leaf's left child Leaf
    public var rightChild:Leaf; // the Leaf's right child Leaf
    public var room:Rectangle; // the room that is inside this Leaf
    public var halls:Vector<Rectangle>; // hallways to connect this Leaf to other Leafs
	

	public function new(X:Int, Y:Int, Width:Int, Height:Int) 
	{
		// initialize our leaf
        x = X;
        y = Y;
        width = Width;
        height = Height;
	}
	 public function split():Bool
    {
        // begin splitting the leaf into two children
        if (leftChild != null || rightChild != null)
            return false; // we're already split! Abort!
 
        // determine direction of split
        // if the width is >25% larger than height, we split vertically
        // if the height is >25% larger than the width, we split horizontally
        // otherwise we split randomly
        var splitH:Bool = FlxRandom.int() > 0.5;
        if (width > height && height / width >= 0.05)
            splitH = false;
        else if (height > width && width / height >= 0.05)
            splitH = true;
 
        var max:Int = (splitH ? height : width) - MIN_LEAF_SIZE; // determine the maximum height or width
        if (max <= MIN_LEAF_SIZE)
            return false; // the area is too small to split any more...
 
        var split:Int = FlxRandom.intRanged(MIN_LEAF_SIZE, max); // determine where we're going to split
 
        // create our left and right children based on the direction of the split
        if (splitH)
        {
            leftChild = new Leaf(x, y, width, split);
            rightChild = new Leaf(x, y + split, width, height - split);
        }
        else
        {
            leftChild = new Leaf(x, y, split, height);
            rightChild = new Leaf(x + split, y, width - split, height);
        }
        return true; // split successful!
    }
	
	public function createRooms()
	{
		// this function generates all the rooms and hallways for this Leaf and all of its children.
			if (leftChild != null || rightChild != null)
			{
				// this leaf has been split, so go into the children leafs
				if (leftChild != null)
				{
					leftChild.createRooms();
				}
				if (rightChild != null)
				{
					rightChild.createRooms();
				}
				// if there are both left and right children in this Leaf, create a hallway between them
				if (leftChild != null && rightChild != null)
				{
					createHall(leftChild.getRoom(), rightChild.getRoom());
				}
			}
		else
		{
			// this Leaf is the ready to make a room
			var roomSize:Point;
			var roomPos:Point;
			// the room can be between 3 x 3 tiles to the size of the leaf - 2.
			roomSize = new Point(FlxRandom.intRanged(3, width - 2), FlxRandom.intRanged(3, height - 2));
			// place the room within the Leaf, but don't put it right 
			// against the side of the Leaf (that would merge rooms together)
			roomPos = new Point(FlxRandom.intRanged(1,width - cast roomSize.x -1), FlxRandom.intRanged(1, height - cast roomSize.y - 1));
			room = new Rectangle(x + roomPos.x , y + roomPos.y , roomSize.x, roomSize.y);
		}
	}
	
	public function getRoom():Rectangle
	{
		// iterate all the way through these leafs to find a room, if one exists.
		if (room != null)
			return room;
		else
		{
			var lRoom:Rectangle = new Rectangle();
			var rRoom:Rectangle = new Rectangle();
			if (leftChild != null)
			{
				lRoom = leftChild.getRoom();
			}
			if (rightChild != null)
			{
				rRoom = rightChild.getRoom();
			}
			if (lRoom == null && rRoom == null)
				return null;
			else if (rRoom == null)
				return lRoom;
			else if (lRoom == null)
				return rRoom;
			else if (Math.random() > 0.5)
				return lRoom;
			else
				return rRoom;
		}
	}
	
	public function createHall(l:Rectangle, r:Rectangle):Void
	{
		halls = new Vector<Rectangle>();
		var point1:Point = new Point(FlxRandom.intRanged(cast l.left + 1, cast l.right - 2), FlxRandom.intRanged(cast l.top + 1,cast l.bottom - 2));
		var point2:Point = new Point(FlxRandom.intRanged(cast r.left + 1,cast r.right - 2), FlxRandom.intRanged(cast r.top + 1,cast r.bottom - 2));
		
		var w:Float = point2.x - point1.x;
		var h:Float = point2.y - point1.y;
		
		if (w < 0)
		{
			if (h < 0)
			{
				if (Math.random() > 0.5)
				{
					halls.push(new Rectangle(point2.x, point1.y, Math.abs(w), 1));
					halls.push(new Rectangle(point2.x, point2.y, 1, Math.abs(h)));
				}
				else
				{
					halls.push(new Rectangle(point2.x, point2.y, Math.abs(w), 1));
					halls.push(new Rectangle(point1.x, point2.y, 1, Math.abs(h)));
				}
			}
			else if (h > 0)
			{
				if (Math.random() > 0.5)
				{
					halls.push(new Rectangle(point2.x, point1.y, Math.abs(w), 1));
					halls.push(new Rectangle(point2.x, point1.y, 1, Math.abs(h)));
				}
				else
				{
					halls.push(new Rectangle(point2.x, point2.y, Math.abs(w), 1));
					halls.push(new Rectangle(point1.x, point1.y, 1, Math.abs(h)));
				}
			}
			else // if (h == 0)
			{
				halls.push(new Rectangle(point2.x, point2.y, Math.abs(w), 1));
			}
		}
		else if (w > 0)
		{
			if (h < 0)
			{
				if (Math.random() > 0.5)
				{
					halls.push(new Rectangle(point1.x, point2.y, Math.abs(w), 1));
					halls.push(new Rectangle(point1.x, point2.y, 1, Math.abs(h)));
				}
				else
				{
					halls.push(new Rectangle(point1.x, point1.y, Math.abs(w), 1));
					halls.push(new Rectangle(point2.x, point2.y, 1, Math.abs(h)));
				}
			}
			else if (h > 0)
			{
				if (Math.random() > 0.5)
				{
					halls.push(new Rectangle(point1.x, point1.y, Math.abs(w), 1));
					halls.push(new Rectangle(point2.x, point1.y, 1, Math.abs(h)));
				}
				else
				{
					halls.push(new Rectangle(point1.x, point2.y, Math.abs(w), 1));
					halls.push(new Rectangle(point1.x, point1.y, 1, Math.abs(h)));
				}
			}
			else // if (h == 0)
			{
				halls.push(new Rectangle(point1.x, point1.y, Math.abs(w), 1));
			}
		}
		else // if (w == 0)
		{
			if (h < 0)
			{
				halls.push(new Rectangle(point2.x, point2.y, 1, Math.abs(h)));
			}
			else if (h > 0)
			{
				halls.push(new Rectangle(point1.x, point1.y, 1, Math.abs(h)));
			}
		}
	}
}
