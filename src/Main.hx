package ;

import cpp.io.File;


/**
 * ...
 * @author scott
 */

class Main 
{
	
	
	static function main() 
	{
		var policyfile:String = File.getContent("crossdomain.xml");
		
		new PolicyFileServer(policyfile);
	}
}