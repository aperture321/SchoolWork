// Thomas Turney
// COP 3003
// Dr. Zalewski
// October 16 2013


import java.io.*;
import java.net.*;
import java.lang.Math.*;

public class jServer extends Thread {
    public final static int DEFAULT_PORT = 6789;
    protected int port;
    protected ServerSocket listen_socket;

    // Exit with an error message when an exception occurs
    public static void fail(Exception e, String msg) {
	System.err.println(msg + ": " + e);
	System.exit(1);
    }

    // Create a ServerSocket to listen for connections;; start the therad
    public jServer(int port) {
	if (port == 0)
	    port = DEFAULT_PORT;
	this.port = port;

	try {
	    listen_socket = new ServerSocket(port);
	}
	catch (IOException e) {
	    fail(e, "Exception creating server socket");
	}
	//starting the server listen.
	this.start();
    }

    // The body of the server thread.  Loops forever listening for
    // connection requests from clients.  For each connection,
    // creates a Connection object to handle communication through
    // the new Socket.
    public void run() {
	try {
	    while (true) {
		Socket client_socket = listen_socket.accept();
		Connection c = new Connection(client_socket);
	    }
	}
	catch (IOException e) {
	    fail(e, "Exception while listening for connections");
	}
	}

    // Start the server up, listening on an optionally specified port
    public static void main(String[] args) {
	int port = 6789;

	if (args.length == 1) {
	    try {
		port = Integer.parseInt(args[0]);
	    }
	    catch (NumberFormatException e) {
		port = 0;
	    }
	}

	new jServer(port);
    }
}

///////////////////////////////////////////////////////////////////////
//A Thread class that handles all communication with client
class Connection extends Thread  { 
    protected Socket client;
    protected ObjectInputStream in;
    protected ObjectOutputStream out;
	protected SerialInp vars;
    // Initialize the streams and start the thread
    public Connection(Socket client_socket) {
	client = client_socket;

	try {
	    in = new ObjectInputStream(client.getInputStream());
	    out = new ObjectOutputStream(client.getOutputStream());
	}
	catch (IOException e) {
	    try {
		client.close();
	    }
	    catch (IOException e2) {
		;
	    }
	    System.err.println("Exception generating socket streams: " + e);
	    return;
	}

	this.start();
    }


	public void calc_roots(SerialInp vars) {
		double[] inps = vars.getInp(); //gives us the three arguments
		double[] outputvars = new double[2]; //output roots
		double descr = (inps[1]*inps[1]) - (4*inps[0]*inps[2]);
		vars.setdesc(descr); //set the descrimenant in the serialized class.
		if (descr < 0.0) {
			outputvars[0] = -1;
			outputvars[1] = -1;
		}
		else {
			outputvars[0] = (-1*inps[1] + Math.sqrt(descr)) / (2*inps[0]);
			outputvars[1] = (-1*inps[1] - Math.sqrt(descr)) / (2*inps[0]);
		}
		vars.setRes(outputvars); //give outputs
	}

    // Provide the service:  read a line, calculate roots, send it back
    public void run() {
	String line;

	try {
	    for (;;) {
		// Read in a line
		vars = (SerialInp)in.readObject();

		// Calculate roots.
		calc_roots(vars);

		// Write out the roots solution.
		out.writeObject(vars);
	    }
	}
	catch(IOException e) {
	    ;
	}
	catch(ClassNotFoundException e) {
		;
	} 

	finally {
	    try {
		client.close();
	    }
	    catch (IOException e2) {
		;
	    }
	}
    }


}
///////////////////////////////////////////////////////////////////////

