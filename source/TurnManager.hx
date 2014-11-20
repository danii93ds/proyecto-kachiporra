package ;

/**
 * ...
 * @author ...
 */
class TurnManager
{
	public static var _instance:TurnManager;

	
	public function new() 
	{
		
	}
	
	public static inline function getInstance()
	{
		if (_instance == null)
			return _instance = new TurnManager();
		else	
			return _instance;
	}
	
	

}