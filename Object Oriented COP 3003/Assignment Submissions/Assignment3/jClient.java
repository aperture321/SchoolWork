// Thomas Turney
// COP 3003
// Dr. Zalewski
// October 16 2013

import java.io.*;
import java.net.*;

public class jClient {
    public static final int DEFAULT_PORT = 6789;

    public static void usage() {
	System.out.println("Usage: java jClient <hostname> [<port>]");
	System.exit(0);
    }

	//performs typechecking and sends strings back for formatting.
	public static String test_values(String a, String b, String c) {
		double value;
		try {
				value = Double.parseDouble(a);
				value = Double.parseDouble(b);
				value = Double.parseDouble(c);
				return a + ";" + b + ";" + c; //returning strings to send to server
			}
		catch (Exception e) {
			System.out.println("Error converting values. Setting values to 1.");
			return "1;1;1";
		}
	}

    public static void main(String[] args) {
	int port = DEFAULT_PORT;
	Socket s = null;

	// Parse the port specification
	if ((args.length != 1) && (args.length != 2))
	    usage();

	if (args.length == 1)
	    port = DEFAULT_PORT;
	else {
	    try {
		port = Integer.parseInt(args[1]);
	    }
	    catch (NumberFormatException e) {
		usage();
	    }
	}

	try {
	    // Create a socket to communicate with a specified host and port
	    s = new Socket(args[0], port);

	    // Create streams for reading and writing lines of text
	    DataInputStream sin = new DataInputStream(s.getInputStream());
	    PrintStream sout = new PrintStream(s.getOutputStream());

	    // Create a stream for reading lines of text from the console
	    DataInputStream in = new DataInputStream(System.in);

	    // Tell the user that we've connected
	    System.out.println("Connected to " + s.getInetAddress() +
				"; " + s.getPort());

	    String a;
		String b;
		String c;
		String roots;

	    while (true) {
		// Print a prompt
		System.out.print("Enter A> ");
		System.out.flush();

		// Read a line from console and check it for EOF
		a = in.readLine();
		if (a == null)
		    break;

		System.out.print("Enter B> ");
		System.out.flush();

		b = in.readLine();
		if (b == null)
		    break;

		System.out.print("Enter C> ");
		System.out.flush();

		c = in.readLine();
		if (c == null)
		    break;
		
		roots = test_values(a,b,c); //here, roots are assigned for server to read

		// Send it to the server
		sout.println(roots);


		// Read a line from the server
		roots = sin.readLine();

		// Check if connection is closed
		if (roots == null) {
		    System.out.println("Connection closed by server.");
		    break;
		}

		// Write the line to the console
		System.out.println(roots);
	    }
	}
	catch (IOException e) {
	    System.err.println(e);
	}
	// Always be sure to close the socket
	finally {
	    try {
		if (s != null)
		    s.close();
	    }
	    catch (IOException e2) {
		;
	    }
	}
    }
}
