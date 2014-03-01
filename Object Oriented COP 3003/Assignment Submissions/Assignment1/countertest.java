//Thomas Turney
//Dr. Zalewski
// 9/4/2013
//COP 3003
import cop3003_pkg.*;

public class countertest {
	countertest(int [] test) {
		for (int i=0;i<test.length;i++) {
			int init = test[i];
			Counter c = new Counter(init);
			System.out.println("\nArgument: " + (i + 1) + " test.");
			//test increment
			for (int j = 0; j < 4; j++) {
				c.increment();	
			}
			System.out.println("\nCount c = " + c.getCount());
			
			c.decrement(); //test decrement
			System.out.println("\nCount c = " + c.getCount());
			
			
		}
		
		//default constructor
		Counter c = new Counter();
		for (int k = 0; k < 4; k++) {
			c.increment();	
		}
		System.out.println("\nIncrement testing");
		System.out.println("\nCount c = " + c.getCount());
			
		System.out.println("\nDecrement testing");
		c.decrement(); //test decrement
		System.out.println("\nCount c = " + c.getCount());
		
		c.setCount(5); //test setcount
		System.out.println("\n Expect five: ");
		System.out.println("\nCount c = " + c.getCount());
		
		c.setMaxValue(15); //test maxValue
		System.out.println("\n Expect fifteen: ");
		System.out.println("\nMaxCount c = " + c.getMaxValue());
		
	}
	public static void main(String [] args) {
		int arr[] = {32, 5, 2}; //note last arg the max value is initialized to 2!
		new countertest(arr);
		
	}
}
