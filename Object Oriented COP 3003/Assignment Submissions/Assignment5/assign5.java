//Thomas Turney
//COP 3003
//Dr. Zalewksi
// 11/27/2013

import java.util.*;
public class assign5 {

   public static void aMethod() {

      myList head = new myList(22);
      myList tail = new myList(21);

      head.link = tail;
      
      for(int i = 0; i < 3000000; i++) {
          tail.link = new myList(i * 3 + 1);
          tail = tail.link;
      }

   }
  
   public static void theMethod() {

      LinkedList head = new LinkedList();
      head.add(22);
      LinkedList tail = new LinkedList();
      tail.add(21);
      head.add(tail);

      for (int i = 0; i < 3000000; i++) {
          tail.add(new LinkedList());
          ((LinkedList)tail.getLast()).add(i * 3 + 1);
          tail = (LinkedList)tail.getLast();     //this is similar to aMethod.
      }
   }
   

   public static void main(String args[]) {

      long startTime;
      long endTime;

      startTime = System.nanoTime();
      aMethod(); //will implement custom linked list insertion
      endTime = System.nanoTime() - startTime;
      System.out.println("Time of aMethod is: " + String.valueOf(endTime) + " nanoseconds");

      startTime = System.nanoTime();
      theMethod(); //will implement array list insertion method
      endTime = System.nanoTime() - startTime;
      System.out.println("Time of theMethod is: " + String.valueOf(endTime) + " nanoseconds");
   }

}

// Class to define a node of a linked list, with puting a value in it
class myList {

   int data;     // field to keep values
   myList link;  // field to refer to another node in a linked list

   myList(int par) {  // constructor to pass a value to a newly created node
      data = par;   
   }
}

