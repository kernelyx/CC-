/*********************************************************
 * 
 * 95-772 Data Structures for Application Programmers
 * Lab 3 Simple Sorting and Stability 
 * 
 * Selection Sort Implementation
 * 
 * Andrew id:
 * Name:
 * 
 *********************************************************/

public class SelectionSortApp {

	public static void main(String[] args) {

		Employee[] list = new Employee[10];

		// employee data : first name, last name, zip
		list[0] = new Employee("Patty", "Evans", 15213);
		list[1] = new Employee("Doc", "Smith", 15214);
		list[2] = new Employee("Lorraine", "Smith", 15216);
		list[3] = new Employee("Paul", "Smith", 15216);
		list[4] = new Employee("Tom", "Yee", 15216);
		list[5] = new Employee("Sato", "Hashimoto", 15218);
		list[6] = new Employee("Henry", "Stimson", 15215);
		list[7] = new Employee("Jose", "Vela", 15211);
		list[8] = new Employee("Minh", "Vela", 15211);
		list[9] = new Employee("Lucinda", "Craswell", 15210);

		System.out.println("Before Selection Sorting: ");
		for (Employee e : list) {
			System.out.println(e.toString());
		}
		System.out.println("");

		selectionSort(list, "last");

		System.out.println("After Selection Sorting by last name: ");
		for (Employee e : list) {
			System.out.println(e.toString());
		}
		System.out.println("");

		selectionSort(list, "zip");

		System.out.println("After Selection Sorting by zip code: ");
		for (Employee e : list) {
			System.out.println(e.toString());
		}
	}

	/*
	 * Sort employees either by last name or zip using Selection Sort value of
	 * the key param should be either "last" or "zip"
	 */
	public static void selectionSort(Employee[] list, String key) {
		// TODO implement selection sort here
		if(key.equals("last")){
			for (int out = 0; out < list.length - 1; out++) {
				int min = out; // initialize min to be out index
				// move forward in variable from out+1 till the end
				for (int in = out + 1; in < list.length; in++) {
					// if there is a smaller value than min
					if (list[in].getLastName().compareTo(list[min].getLastName()) <0)
						min = in; // update min index to be in
				}
				if(out != min)
					swap(list, out, min); // then swap it with the out
			}
		}
		
		
		// sort by zipcode
		if(key.equals("zip")){
			for (int out = 0; out < list.length - 1; out++) {
				int min = out; // initialize min to be out index
				// move forward in variable from out+1 till the end
				for (int in = out + 1; in < list.length; in++) {
					// if there is a smaller value than min
					if (list[in].getZipCode()< list[min].getZipCode())
						min = in; // update min index to be in
				}
				if(out != min)
					swap(list, out, min); // then swap it with the out
			}
			
		}
		
	}

	// private helper method to swap elements in an array
	private static void swap(Employee[] list, int one, int two) {
		Employee temp = list[one];
		list[one] = list[two];
		list[two] = temp;
	}

}