

import java.util.Random;

/**
 * Examples for Lab 5 in CDA 3104
 *
 * @author Dahai Guo
 * @since Oct 25, 2013
 */
public class Lab5 {

	public static void main(String[] args) {
		byte vector1[] = {1,2,3,4,5,6,7,8,9,10};
		byte vector2[] = {20,19,18,17,16,15,14,13,12,11};
		System.out.println(countDistance(vector1, vector2)+
				" bits are different between vector1 and vector2");
		System.out.println();

		int rand = (new Random()).nextInt(Integer.MAX_VALUE);
		printIntInBinary(rand);
		printIntInBinary(swapOddEvenBits(rand));

		System.out.println(countOnes((byte) -128));
	}

	/**
	 * Prints a number in binary format
	 * @param num
	 */
	public static void printIntInBinary(int num) {
		int mask = 1;
		StringBuilder bin = new StringBuilder(32);
		for(int i=0;i<32;i++){
			if((num&mask)>0){
				bin.append('1');

			}else{
				bin.append('0');
			}
			mask = mask<<1;
		}
		bin.reverse();
		System.out.println(bin);
	}

	/**
	 * Exchanges every pair of bits in a 32-bit integer
	 *
	 * @param num
	 * @return
	 */
	public static int swapOddEvenBits(int num) {
		int mask = 3, result = 0;
		for(int i=0;i<32;i+=2){
			// isolates the current pair of bits
			mask = mask << i;
			mask = mask & num;

			// shifts the bits to the rightmost
			mask = mask >>i;

			// when the pair of bits are different
			// xor the bits and 11b to flips both bits
			if(mask==1 || mask==2){
				mask = mask ^ 3;
			}// otherwise, two bits are same, no swap needed

			// shifts the bits to where they were
			mask = mask << i;

			// add to the result
			result += mask;

			// reset the mask
			mask = 3;
		}
		return result;
	}

	/**
	 * Counts how many bits in two byte vectors are different
	 *
	 * @param vector1
	 * @param vector2
	 * @return
	 */
	public static int countDistance(byte [] vector1, byte [] vector2) {
		int count=0;
		for(int i=0;i<vector1.length;i++){
			// xor vector1[i] and vector2[i], only the pairs of bits with different values
			// will result in 1
			byte xor = (byte) (vector1[i]^vector2[i]);

			// counts how many 1's in xor
			count+=countOnes(xor);
		}

		return count;
	}

	/**
	 * Counts how many bits in b are 1.
	 * @param b
	 * @return
	 */
	public static int countOnes(byte b) {
		int count=0;
		while(b!=0){
			count++;
			// clears the least significant 1 in b.
			b = (byte) (b & (b-1));
		}
		return count;
	}
}
