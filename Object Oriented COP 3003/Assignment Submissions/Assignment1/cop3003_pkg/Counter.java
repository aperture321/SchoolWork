//Thomas Turney
//Dr. Zalewski
// 9/4/2013
//COP 3003
package cop3003_pkg;

public class Counter {

   int count;
   int maxValue;

   public Counter() {  // Class constructor
      	count = 0;
   	maxValue = 100; //INT_MAX ?
   }

   public Counter(int val) {  // Class constructor
     	count = 0;
     	maxValue = val;
   }

   public boolean increment() {
	if (count < maxValue-1) {
		count++;
		return false;
	}
	else {
		count = 0;
		return true;
	}
   }

   public boolean decrement() {
      if (count > 0) {
	      count--;
	      return false;
      }
      else {
	      count = maxValue-1;
	      return true;
      }
   }

   public int getCount() {
      return count;
   }

   public boolean setCount(int val) {
      if (val >= 0 && val <= maxValue) {
	      count = val;
	      return false;
      }
      else {
	      count = 0;
	      System.out.println("\n\tAttempt to set count to invalid value!!");
	      return true;
      }
   }

   public int getMaxValue() {
      return maxValue;
   }

   public void setMaxValue(int val) {
      maxValue = val;
   }
}
