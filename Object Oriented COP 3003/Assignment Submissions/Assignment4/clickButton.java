/*Thomas Turney
* Janusz Zalewski
* COP 3003
* Assignment 4
* 11/6/2013
*/

//Synopsis:
//Create two editable text fields, and a button to calculate roots, and an uneditable text field (results).
//On button click check to make sure valid inputs were made, or show error on on results text field.
//Package in the jClient that's serializable. Send to server.
//Server should think about this, return serialized results, or -1 for no solution...
//Java applet should return whatever server says to editable text.
import java.applet.*;
import java.awt.*;
import java.net.*;
import java.io.*;
import java.io.Serializable;
public class clickButton extends Applet {
   TextField ain, bin, cin, results;

   public void init() {
	ain = new TextField("Enter A", 20);
	add(ain);
	bin = new TextField("Enter B", 20);
	add(bin);	
	cin = new TextField("Enter C", 20);
	add(cin);
	add(new Button("Run program"));
	results = new TextField("Roots will go here.", 20);
	results.setEditable(false);
	add(results);
   }

    public boolean action(Event e, Object arg) {
		if (((Button)e.target).getLabel() == "Run program") {
		    results.setText("Program running.");
			results.setText(setargs());
		}
 	    else
	    	results.setText("Button clicked.");

		return true;
    }

	//will set as serializable!
	public String setargs() { //sending through array for jServer.
		double value1, value2, value3 = 0.0; //a, b, c
		try {
			value1 = Double.parseDouble(ain.getText());
			}
		catch(Exception e) {
			return "Error with parsing value A.";
			}

		try {
			value2 = Double.parseDouble(bin.getText());
			}
		catch(Exception e) {
			return "Error with parsing value B.";
			}

		try {
			value3 = Double.parseDouble(cin.getText());
			}
		catch(Exception e) {
			return "Error with parsing value C.";
			}

//starting the socket send and reciever...
		try {

		    Socket socket = new Socket("127.0.0.1", 6789); //setup for server to send to...

		    ObjectOutputStream OutStream = new ObjectOutputStream(socket.getOutputStream());//output stream
		    ObjectInputStream InStream = new ObjectInputStream(socket.getInputStream()); //input stream for data
	 
			SerialInp initial = new SerialInp(value1, value2, value3); //serialized objects
		    OutStream.writeObject(initial); //sends object to the server

			//gives returned variables in Serialized class        
		    SerialInp returnVariables = (SerialInp)InStream.readObject(); 
			double desc = returnVariables.getdesc(); //will get your descrimannt
			if(desc < 0) { //impossible
				socket.close();
				return "No Solution.";
			}
			else {
				double[] results = returnVariables.getRes();
				socket.close();
				return "Root1: " + Double.toString(results[0]) + " Root2: " + Double.toString(results[1]);
				}
		}
		catch(Exception e) {
			System.err.println("Caught IOException: " + e.getMessage());
			return "Error occurred when sending to Server.";
		}
	}

}

class SerialInp implements Serializable {
	double a, b, c;
	double desc;
	double[] arr = new double[3];
	double[] results = new double[2];
	public SerialInp(double a, double b, double c) {
		this.a = a;
		this.b = b;
		this.c = c;
		this.arr[0] = this.a;
		this.arr[1] = this.b;
		this.arr[2] = this.c;
	}
	public double[] getInp() {
		return this.arr;
	}
	public void setdesc(double des) { //will set your descriminant for it.
		this.desc = des;
	}	
	public double getdesc() {
		return this.desc;
	}
	public double[] getRes() {
		return this.results;
	}
	public void setRes(double[] res) {
		this.results = res;
	}
		
}
