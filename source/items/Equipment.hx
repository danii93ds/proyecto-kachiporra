package items ;

/**
 * ...
 * @author ...
 */
class Equipment
{
	//Type
	private var _Name:String;
	
	private var _Level:Int;
	
	public function new() 
	{
		
	}
	
	public function NameGet():String { 
		return _Name; 
	}
	
	public function Level():Int {
		return _Level;
	} 
}