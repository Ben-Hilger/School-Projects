
public class ArrayUtilityDriver {

	
	public static void main(String[] args) {
		
		ArrayUtility bag = new ArrayUtility();
		
		testClear();
		
		testGetCurrentSize();
		
		testIsEmpty();
		
		testContains();
		
		testGet();
		
		testIndexOf();
		
		testGetFrequencyOf();
		
		testAddInt();
		
		testAddIntIndex();
		
		testRemove();		

		testRemoveFirst();
		
		testRemoveLast();
		
		testRemoveMiddle();
		
		testReverse();
		
	}

	public static void testClear() {
		
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println("Testing clear() method");
		
		bag.add(23);
		bag.add(56);
		System.out.println("Current Contents of the Bag: " + bag.getCurrentSize());
		
		bag.clear();
		
		System.out.println("The bag should be empty: " + bag.getCurrentSize());
		
		System.out.println();
		System.out.println();
	}
	
	public static void testGetCurrentSize() {
		
		System.out.println("Testing getCurrentSize() method");
		
		ArrayUtility bag = new ArrayUtility();
		
		bag.add(23);
		bag.add(56);
		bag.add(56);
		System.out.println("The current size of the bag should be 3: " + bag.getCurrentSize());
		
		bag.removeFirst();
		bag.removeFirst();
		System.out.println("The current size of the bag should be 1: " + bag.getCurrentSize());
		
		System.out.println();
		System.out.println();
	}
	
	public static void testIsEmpty() {

		System.out.println("Testing isEmpty() method");
		
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println("The bag should be empty: " + bag.isEmpty());
		
		bag.add(23);
		bag.add(21);
		
		System.out.println("The bag shouldn't be empty: " + bag.isEmpty());
		
		bag.removeFirst();
		bag.removeFirst();
		
		System.out.println("The bag should be empty, the bag is currently" + (bag.isEmpty() ? " empty" : " no empty"));
		
		System.out.println();
		System.out.println();
		
	}
	
	public static void testContains() {

		System.out.println("Testing contains() methods");
		
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println("The bag shouldn't contain 23, the bag currently" + (bag.contains(23) ? " contains it" : " doesn't contain it")  );
		
		bag.add(23);
		bag.add(12);
	
		System.out.println("The bag should contain 23, the bag currently" + (bag.contains(23) ? " contains it" : " doesn't contain it")  );
		
		System.out.println();
		System.out.println();
		
	}
	
	public static void testGet() {
		
		System.out.println("Testing get() methods");

		ArrayUtility bag = new ArrayUtility();
		
		for(int i = 0; i < 10; i++) {
			bag.add(12);
		}
		
		System.out.println("The bag shouldn't have an 11th index, and therefore return null, the value of the 11th index is " + bag.get(11));
		System.out.println("The bag shouldn't have an -1 index, and therefore return null, the value of the -1 index is " + bag.get(-1));
		System.out.println("The bag should have an 9th index, and therefore return 12, the value of the 9 index is " + bag.get(9));
		
		bag.removeLast();
		
		System.out.println("The bag shouldn't have an 9th index, and therefore return 12, the value of the 9 index is " + bag.get(9));
		
		System.out.println();
		System.out.println();
				
	}
	
	public static void testIndexOf() {
		
		System.out.println("Testing indexof() methods");
		
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println("The bag shouldn't have a value 12, and return -1: " + bag.indexOf(12));
		
		bag.add(12);
		bag.add(12);
		
		System.out.println("The bag should have a value 12, and return 0: " + bag.indexOf(12));

		bag.add(13);
		
		System.out.println("The bag should have a value 13, and return 2: " + bag.indexOf(13));

		System.out.println();
		System.out.println();
	}
	
	public static void testGetFrequencyOf() {
		
		System.out.println("Testing getFrequencyOf() method");
		
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println ("The frequency of 12 should be zero: " + bag.getFrequencyOf(12));
		bag.add(12);
		bag.add(12);
		bag.add(13);
		bag.add(15);
		System.out.println ("The frequency of 12 should be two: " + bag.getFrequencyOf(12));
		System.out.println ("The frequency of 15 should be one: " + bag.getFrequencyOf(15));
		
		System.out.println();
		System.out.println();
	}
	
	public static void testAddInt() {
	
		System.out.println("Testing add(Integer) method");
				
		ArrayUtility bag = new ArrayUtility();
		
		System.out.println("You should be able to add 12: " + bag.add(12));
		
		for(int i = 0; i < 9; i++) {
			bag.add(9);
		}
		
		System.out.println("You shouldn't be able to add 12: " + bag.add(12));
		
		System.out.println();
		System.out.println();
		
	}
	
	public static void testAddIntIndex() {
		
		System.out.println("Testing add(Integer, index) method");
		
		ArrayUtility bag = new ArrayUtility(5);
		
		System.out.println("You shouldn't be able to add 12 at index 1: " + bag.add(12, 1));
		System.out.println("You should be able to add 12 at index 0: " + bag.add(12, 0));
		System.out.println("Now you should be able to add 14 at index 1: " + bag.add(14, 1));
		System.out.println("However, you can't add 12 at index 3: " + bag.add(12, 3));
		
		System.out.println();
		
		bag.add(14);
		bag.add(14);
		bag.add(14);
		
		System.out.println("You shouldn't be able to add 16 at index 4: " + bag.add(16, 4));
		
		bag.removeFirst();
		
		System.out.println("You should be able to add 16 at index 2: " + bag.add(16, 2) + " and it's now at index: " + bag.indexOf(16));
		System.out.println("You should be able to add 16 at index -1: " + bag.add(16, -1));
		
		System.out.println();
		System.out.println();
		
	}
	
	public static void testRemove() {
		
		System.out.println("Testing remove(Integer) method");
		
		ArrayUtility bag = new ArrayUtility(5);
		
		System.out.println("It shouldn't be able to remove 15 from an empty bag: " + bag.remove(15));
		bag.add(15);
		System.out.println("It should be able to remove 15: " + bag.remove(15));
		System.out.println("It shouldn't be able to remove 15 twice: " + bag.remove(15));
		
		bag.add(14);
		bag.add(14);
		bag.add(14);
		bag.add(14);
		bag.add(10);
		
		System.out.println("It should be able to remove 10: " + bag.remove(10));
		System.out.println("It shouldn't be able to remove 10 twice: " + bag.remove(10));
		System.out.println("It shouldn't be able to remove 12 since it's not in bag: " + bag.remove(12));
		System.out.println("It should be able to remove 14: " + bag.remove(14));
		
		System.out.println();
		System.out.println();
	}
	
	public static void testRemoveFirst() {

		System.out.println("Testing removeFirst() method");
		
		ArrayUtility bag = new ArrayUtility(5);
		
		System.out.println("It shouldn't be able to remove anything from an empty bag: " + bag.removeFirst());
		
		bag.add(15);
		bag.add(45);
		
		System.out.println("It should be able to remove from the first index: " + bag.removeFirst());
		System.out.println("It should be able to remove from the first index: " + bag.removeFirst());
		System.out.println("It shouldn't be able to remove from the first index: " + bag.removeFirst());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		System.out.println("It should be able to remove from the first index: " + bag.removeFirst());

		System.out.println();
		System.out.println();
	}
	
	public static void testRemoveLast() {
		
		System.out.println("Testing removeLast() method");
		
		ArrayUtility bag = new ArrayUtility(5);
		
		System.out.println("It shouldn't be able to remove anything from an empty bag: " + bag.removeLast());
		
		bag.add(15);
		bag.add(45);
		
		System.out.println("It should be able to remove from the last index: " + bag.removeLast());
		System.out.println("It should be able to remove from the last index: " + bag.removeLast());
		System.out.println("It shouldn't be able to remove from the last index: " + bag.removeLast());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		System.out.println("It should be able to remove from the last index: " + bag.removeLast());
		

		System.out.println();
		System.out.println();
		
	}
	
	public static void testRemoveMiddle() {
		
		System.out.println("Testing removeLast() method");
		
		ArrayUtility bag = new ArrayUtility(5);
		
		System.out.println("It shouldn't be able to remove anything from an empty bag: " + bag.removeMiddle());
		
		bag.add(15);
		bag.add(45);
		
		System.out.println("It should be able to remove from the last index: " + bag.removeMiddle());
		System.out.println("It should be able to remove from the last index: " + bag.removeMiddle());
		System.out.println("It shouldn't be able to remove from the last index: " + bag.removeMiddle());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		System.out.println("It should be able to remove from the last index: " + bag.removeMiddle());
				
		System.out.println();
		System.out.println();
	}
	
	public static void testReverse() {
		
		System.out.println("Testing reverse() method");
		
		ArrayUtility bag = new ArrayUtility();
		
		bag.add(15);
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
	
		bag.reverse();
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.add(45);
		bag.add(56);
		
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.reverse();
		
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.add(89);
		
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.reverse();
		
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.add(78);
		bag.add(69);
		bag.add(84);
		

		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		bag.reverse();
		
		System.out.print("Current Contents: ");
		printArrayUtility(bag);
		
		System.out.println();
		System.out.println();
	}
	
	public static void printArrayUtility(ArrayUtility au) {
		
		for(int i = 0; i < au.getCurrentSize(); i++) {
			System.out.print(au.get(i) + " ");
		}
		System.out.println();
		
	}
	
	
	
}
