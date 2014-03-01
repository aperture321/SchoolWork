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
	int port = 0;

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
class Connection extends Thread {
    protected Socket client;
    protected DataInputStream in;
    protected PrintStream out;

    // Initialize the streams and start the thread
    public Connection(Socket client_socket) {
	client = client_socket;

	try {
	    in = new DataInputStream(client.getInputStream());
	    out = new PrintStream(client.getOutputStream());
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

	public String calc_roots(String values) {
		String[] temp = values.split(";"); //setup our doubles..
		
		double a = Double.parseDouble(temp[0]); //assign double values.
		double b = Double.parseDouble(temp[1]);
		double c = Double.parseDouble(temp[2]);
		double descr = (b*b)-(4*a*c); //if descriminant is negative, roots do not exist.
		if (descr < 0.0) { return "No solution"; }
		else {
			double r1 = (-1*b + Math.sqrt(descr)) / (2*a); //get roots.
			double r2 = (-1*b - Math.sqrt(descr)) / (2*a);
			return "root1: " + Double.toString(r1) + " root2: " + Double.toString(r2);
		}
    }

    // Provide the service:  read a line, calculate roots, send it back
    public void run() {
	String line;

	try {
	    for (;;) {
		// Read in a line
		line = in.readLine();
		if (line == null)
		    break;

		// Calculate roots.
		line = calc_roots(line);

		// Write out the roots solution.
		out.println(line);
	    }
	}
	catch(IOException e) {
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

