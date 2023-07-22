
public class IntegerContainerDriver {

	public static void main(String[] args) {
		// Creates a default instance of the integer container
		IntegerContainer ic = new IntegerContainer();
		// Prints the integer container size (should be 0)
		System.out.println("Size: " + ic.getCurrentSize());
		// Prints if the container is empty (should be true)
		System.out.println("Is empty?: " + ic.isEmpty());
		// Prints the results of adding the integer 3 to the container (true)
		System.out.println("Add 3 to the current container: " + ic.add(3));
		// Prints the current size of the container (should be 1)
		System.out.println("Size: " + ic.getCurrentSize());
		// Prints if the container is still empty (should now be false)
		System.out.println("Is empty?: " + ic.isEmpty());
	}

}
