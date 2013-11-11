/***********************************************************
 * 
 * 95-772 Data Structures for Application Programmers
 * Lab 3 Simple Sorting Performance Comparison
 * 
 * O(n^2) : Bubble Sort, Selection Sort, and Insertion Sort 
 * 
 ***********************************************************/
import java.util.*;

public class SimpleSortDemo {
	private static final int SIZE = 10000;
	private static Random rand = new Random();

	public static void main(String[] args) {
		// create three int arrays
		int[] a = new int[SIZE];
		int[] b = new int[SIZE];
		int[] c = new int[SIZE];

		// Case 1: put random numbers into array a
		for (int i = 0; i < SIZE; i++) {
			a[i] = rand.nextInt();
		}

		// Case 2: put reversely ordered values
		/*
		 * for(int i = 0; i<SIZE; i++) { a[i] = SIZE-i; }
		 */

		// Case 3: put ordered values
		/*
		 * for(int i = 0; i<SIZE; i++) { a[i] = i; }
		 */

		// copy all of the values from a to b and c arrays
		System.arraycopy(a, 0, b, 0, a.length);
		System.arraycopy(a, 0, c, 0, a.length);

		// check the running time for bubble sort
		Stopwatch timer1 = new Stopwatch();
		bubbleSort(a);
		System.out.println("Time for bubble sort: " + timer1.elapsedTime()
				+ " millisec");

		// check the running time for selection sort
		Stopwatch timer2 = new Stopwatch();
		selectionSort(b);
		System.out.println("Time for selection sort: " + timer2.elapsedTime()
				+ " millisec");

		// check the running time for insertion sort
		Stopwatch timer3 = new Stopwatch();
		insertionSort(c);
		System.out.println("Time for insertion sort: " + timer3.elapsedTime()
				+ " millisec");

	}

	public static void bubbleSort(int[] array) {
		// move backward till index 1
		for (int out = array.length - 1; out >= 1; out--) {
			for (int in = 0; in < out; in++) {
				// if left value is bigger than right value
				if (array[in] > array[in + 1])
					swap(array, in, in + 1); // swap them
			}
		}
	}

	public static void selectionSort(int[] array) {
		int min; // min variable to be updated
		// move forward out variable till array.length-1
		for (int out = 0; out < array.length - 1; out++) {
			min = out; // initialize min to be out index
			// move forward in variable from out+1 till the end
			for (int in = out + 1; in < array.length; in++) {
				// if there is a smaller value than min
				if (array[in] < array[min])
					min = in; // update min index to be in
			}
			if(out != min)
				swap(array, out, min); // then swap it with the out
		}
	}

	public static void insertionSort(int[] array) {
		// move forward from 1 to the end
		for (int out = 1; out < array.length; out++) {
			int tmp = array[out]; // save the value temporarily
			int in = out;
			/*
			 * shift (copy) values to right by one if the value is bigger than
			 * tmp value to find the position to INSERT the tmp value
			 */
			while (in > 0 && array[in - 1] >= tmp) {
				array[in] = array[in - 1];
				in--;
			}
			// now time to INSERT the tmp value at the right position
			array[in] = tmp;
		}
	}

	// swap helper method
	private static void swap(int[] array, int one, int two) {
		int tmp = array[one];
		array[one] = array[two];
		array[two] = tmp;
	}

}