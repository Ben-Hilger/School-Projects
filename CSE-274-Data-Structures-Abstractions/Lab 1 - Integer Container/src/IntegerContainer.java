
public class IntegerContainer implements ContainerInterface<Integer> {

	// A storage to store multiple integers
	private Integer [] data;
	// An integer index which keeps track of the next available location
	private int size;
	// A constant, the maximum capacity of the container
	public static int DEFAULT_CAPACITY = 10;
	
	public IntegerContainer() {
		// Initalizes the container with the default capacity
		data = new Integer[DEFAULT_CAPACITY];
		size = 0;
	}
	
	
	@Override
	public int getCurrentSize() {
		return size;
	}

	@Override
	public boolean isEmpty() {
		return size == 0; 
	}

	@Override
	public boolean add(Integer newObject) {
		// Checks if there's still space for a new object
		if(size >= DEFAULT_CAPACITY) 
			// Returns false to reflect not enough space
			return false;
		
		// Adds the object to the next available space
		data[size] = newObject;
		// Increments the size
		size++;
		// Returns true to reflect the success in adding the object
		return true;
	}

	@Override
	public boolean remove(Integer anObject) {
		// Explores the container objects
		for(int i = 0; i < size; i++) {
			// Checks if the current data is equal to the one specified
			if(data[i].equals(anObject))
				// Sets the current value to value at the end of the container
				data[i] = data[size - 1];
				// Removes the value at the end of the container
				data[size - 1] = null;
				// Decreases the size to reflect the loss of the integer
				size--;
				// Returns true to reflect the success of removing the value
				return true;
		}
		// Returns false since the value wasn't found
		return false;
	}

	@Override
	public boolean contains(Integer anObject) {
		// Explores the container objects
		for(int i = 0; i < size; i++) {
			// Checks if the  current data equals the one specified
			if(data[i].equals(anObject))
				// Returns true since it was found
				return true;
		}
		// Returns false since it wasn't found
		return false;
	}

}







