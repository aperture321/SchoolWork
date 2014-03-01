/*
* Thomas Turney
* Dr. Zalewski
* COP 3003
* Assignment #2
* 9/19/2013
*/

//basic imports
import java.io.*;
import java.lang.Math;
import javagently.*;

class multiquad {
    public static void main(String args[]) {
        try {
            new threader(Integer.parseInt(args[0]));
        } catch (Exception e) {
            System.out.println("Please supply a proper integer.");
        }
    }
}

class threader  { 
    threader(int times) throws InterruptedException {
        readThr thrArr[] = new readThr[times];
        outThr outArr[] = new outThr[times];            //create each thread.
        rootThr rootArr[] = new rootThr[times];

        try {
            //rout is for roots outputs
            File file = new File("results.dat");
            BufferedWriter output = new BufferedWriter(new FileWriter(file));
            for(int i = 0; i < times; i++) {
                PipedOutputStream out = new PipedOutputStream();
                PipedOutputStream rout = new PipedOutputStream();

                //rinp is for roots input stream
                PipedInputStream  inp = new PipedInputStream(out);
                PipedInputStream  rinp = new PipedInputStream(rout);
                
                
                thrArr[i] = new readThr(out);
                rootArr[i] = new rootThr(rout, inp, out);
                                    //needs pipes for roots and originals
                                    //second original is needed because pipe empties
                outArr[i] = new outThr(inp, rinp, output); 
            
                thrArr[i].start();
                thrArr[i].join(); //by joining threads, we can ensure
                                    //all are made on time in order for results
                
                rootArr[i].start();
                rootArr[i].join();
                
                outArr[i].start();
                outArr[i].join();
            }
            output.close();  //close the file to show it has been written to.
            rootArr[0].graph(times); //final activity is graphic.
                    //0 is the only guarenteed working element in the array.
        }
        catch (Exception e) {
            System.out.println("Thread exception " + e + " occurred.");
        }
    }
}

//Thread to read inputs and call other threads!
class readThr extends Thread {

    BufferedReader IOobj = new BufferedReader(new InputStreamReader(System.in));
    DataOutputStream out;

    public readThr(OutputStream os) {
        out = new DataOutputStream(os);
    }
    
    public void run() {
        double [] numb = new double [3]; //array needed as specs requested.
        boolean running = true;
        while (running) {
            try { 
                System.out.print("Enter A: ");
                numb[0] = Double.parseDouble(IOobj.readLine());

                System.out.print("Enter B: ");
                numb[1] = Double.parseDouble(IOobj.readLine());

                System.out.print("Enter C: ");
                numb[2] = Double.parseDouble(IOobj.readLine());

                
                //Time to put things through the pipe...
                for (int i = 0; i < 3; i++) {
                    out.writeDouble(numb[i]); //iterative array writing.
                    out.flush(); //make sure it makes it through.
                }
                running = false;
                
            }
            catch (Exception ex) {
                System.out.println("Exception: " + ex + " occurred while gathering data.");
            }
        }
    }

}

//Thread to calc roots and graphs

class rootThr extends Thread {

    DataOutputStream outroots;
    DataInputStream inorig;
    DataOutputStream out;
    
    public rootThr(OutputStream osroot, InputStream isorig, OutputStream os) {
        outroots = new DataOutputStream(osroot);
        inorig = new DataInputStream(isorig);
        out = new DataOutputStream(os);
    }

    //method for graphing, times is how many inputs were given at start of program.
    public void graph(int times) {
        try {
            double [] allnums = new double[2*times]; //two roots per time!
            
            BufferedReader reader;
            File file = new File("results.dat");
            reader = new BufferedReader(new FileReader(file));
            String line = reader.readLine();
            
            int index = 2; //every third line (0 first order)
            int counter = 0; //for building array

            for(int i = 0; line != null; i++) {
                String [] data = line.split(" "); //split string data
                
                if(i == index) {                                          
                    try { 
                        //These will either take off the semicolon, or fail because
                        //data[5] is out of bounds.
                        String test1 = data[2].substring(0, data[2].length() - 1);
                        String test2 = data[5].substring(0, data[5].length() - 1);

                        //add to our list of root numbers
                        allnums[counter] = Double.parseDouble(test1);
                        allnums[counter+1] = Double.parseDouble(test2);
                         }
                    catch (Exception e) { 
                        //we recognize the times in graph, but these are points.
                        allnums[counter] = 0.0;
                        allnums[counter+1] = 0.0;
                    }
                    
                    finally { index += 3; counter += 2; } 
                }
                
                line = reader.readLine();
            }

            //Now it is time to graph.

            Graph g = new Graph("Output", "Input Number", "roots");

            g.setSymbol(true);
            g.setSymbol(3);
            g.setColor(2);
            for(int j = 0; j < times; j++) {
                g.add(j,allnums[j*2]);            
            }


            g.nextGraph();
            g.setSymbol(2);
            g.setColor(3);            
            for(int k = 0; k < times; k++) {
                g.add(k, allnums[k*2+1]);
            }

            g.showGraph();        

        }
        
        catch (Exception e) { 
            System.out.println("Error occurred while graphing.");
            System.out.println("Error was: " + e);
            }
    
    }

    public void run() {
        double [] numbs = new double [3];
        int counter = 0;

        ///First, read in the array.
        while (counter != 3) {
            try {
                numbs[counter] = inorig.readDouble();
                counter++;
            }
            catch (Exception e) {
                continue;
            }
        }

        //Then, calculate roots and put to pipe and graph.
        try {
        
            double discr = numbs[1] * numbs[1] - 4*numbs[0]*numbs[2];
            double [] roots = new double[2];
            roots[0] = (-1 * numbs[1] + Math.sqrt(discr))/(2*numbs[0]);
            roots[1] = (-1 * numbs[1] - Math.sqrt(discr))/(2*numbs[0]);
            
            if (discr < 0) { //no solution
                roots[0] = 0.01;
                roots[1] = 0.01; 
             }
             outroots.writeDouble(roots[0]);
             outroots.flush();
             outroots.writeDouble(roots[1]);
             outroots.flush();
            
            for(int i = 0; i < 3; i++) {
                out.writeDouble(numbs[i]); //give back to pipes
                out.flush();
            }

            
        }

        catch (IOException e) {
            System.out.println("Error while calculating roots: " + e);
        }

    }

}

//Thread to output text to file
class outThr extends Thread {

    DataInputStream inorig;
    DataInputStream inroots;
    BufferedWriter output;

    public outThr(InputStream isorig, InputStream isroot, BufferedWriter outut) {
        inorig = new DataInputStream(isorig);
        inroots = new DataInputStream(isroot);
        output = outut; //File output is now linked
    }

    public void run() {
        double [] originals = new double[3];
        double [] roots = new double[2];
        int counter = 0;
        
        try {
            while (counter != 3) {
                originals[counter] = inorig.readDouble();
                counter++;
            }
            counter = 0; //this time for roots, which is two.
            while (counter != 2) {
                roots[counter] = inroots.readDouble();
                counter++;
            }
        }    
        catch (Exception e) {
            System.out.println("Error reading pipes.");
            System.out.println("Exception is: " + e );
        }

        //write to file
        try {
            output.write("For coefficients:");
            output.newLine();
            output.write("a = " + originals[0] + "; b = " + originals[1] + "; c = " + originals[2] +";");
            output.newLine();
            if (roots[0] == 0.01) { 
                if (roots[1] == 0.01) { //means roots do not exist
                    output.write("real roots do not exist.");
                    output.newLine();
                }
            }
            else {
                output.write("root1 = " + roots[0] +"; root2 = " + roots[1] + ";");
                output.newLine();
            }
        }
        catch (IOException e) {
            System.out.println("Error writing results to file. Try again.");
        }

    }
}

