package ;

import cpp.net.Host;
import cpp.net.Socket;

/**
 * ...
 * @author scott
 */

class PolicyFileServer 
{

	var server:Socket;
	var policyfile:String;
	var clients:List<Socket>;
	
	static inline var policyFileRequest = "<policy-file-request/>";
	
	public function new(policyfile:String, ?connections:Int = 10, ?port = 843, ?host:String = "localhost"):Void 
	{
		server = new Socket(); clients = new List<Socket>();
		this.policyfile = policyfile;
		
		server.bind(new Host(host), port);
		server.listen(connections);
		
		trace(
			"\n\nPolicy File Server Started." +
			"\n\nPort:\n" + port +
			"\n\nHost:\n" + host +
			"\n\nPolicy File:\n" + policyfile +
			"\n\n"
		);
		
		
		while(true)tick();
	}
	inline function tick():Void 
	{
		acceptConnections();
		
		for (client in clients)
			if (StringTools.startsWith(client.read(), policyFileRequest)) {
				client.write(policyfile + new StringBuf().addChar(0));
				closeConnection(client);
			}
	}
	inline function acceptConnections():Void 
	{
		var client:Socket = server.accept();
		
		if (client != null){
			clients.add(client);
			trace("connected: " + client.peer().host.toString());
		}
	}
	function closeConnection(client:Socket):Void 
	{
		client.close();
		clients.remove(client);
		client = null;
	}
}