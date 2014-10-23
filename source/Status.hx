package  ;

/**
 * ...
 * @author ...
 */
class Status
{

	private var _name:String;
	private var _turnsLeft:Int;
	
	public function new(name:String, turns:Int) 
	{
		_name = name;
		_turnsLeft = turns;
	}
	
	public function getName():String { return _name; }
	public function setName(name:String) { _name = name; }
	public function getTurns():Int { return _turnsLeft; }
	public function setTurns(turns:Int) { _turnsLeft = turns; }
	
}