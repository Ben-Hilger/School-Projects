import java.util.Arrays;

public class NoDuplicatesQueueArray<T> implements NoDuplicatesQueueInterface<T> {

	private static final int DEFAULT_CAPACITY = 10;
	private T[] queue;
	private int numberOfEntries;
	
	public NoDuplicatesQueueArray() {
		this(DEFAULT_CAPACITY); // Creates an empty queue with the default capacity
	}
	
	@SuppressWarnings("unchecked")
	public NoDuplicatesQueueArray(int initialCapacity) {
		queue = (T[]) new Object[initialCapacity]; // Creates an empty queue with the specified capacity
		numberOfEntries = 0; // Sets the number of entries to zero 
	}
	
	@Override
	public void enqueue(T newEntry) {
		
		// Checks to see if the array is full
		if(numberOfEntries == queue.length) {
			queue = Arrays.copyOf(queue, queue.length * 2); // Doubles the size of the queue
		}
		
		// Checks to make sure the entry isn't already in the queue
		for(int i = 0; i < numberOfEntries; i++) {
			// Checks to see if the current data being explored is equal the data specified
			if(queue[i].equals(newEntry)) {
				return;
			}
		}
		
		queue[numberOfEntries] = newEntry; // Adds the entry in the next available spot
		numberOfEntries++; // Increases the number of entries by one

	}

	@Override
	public T dequeue() {
		
		// Checks to see if the queue is empty
		if(isEmpty()) {
			throw new EmptyQueueException(); // Throws an error to the user 
		}
		
		T value = getFront(); // Gets the current front value
		numberOfEntries--; // Decreases the number of entries  
		// Explores all of the data, moving every entry up one and removing the first one
		for(int i = 0; i < numberOfEntries; i++) {
			queue[i] = queue[i+1]; // Moves up the data one entrys
		}
		
		// Returns the value removed from the user
		return value;
	}

	@Override
	public T getFront() {
		// TODO Auto-generated method stub
		if(isEmpty()) {
			throw new EmptyQueueException();
		}
	
		T front = queue[0]; // Gets the item at the front of the array, which is the front of the queue		
		return front; // Returns the front to the user
	}

	@Override
	public boolean isEmpty() {
		return numberOfEntries == 0; // Returns true if the numberOfEntries is equal to zero
	}

	@SuppressWarnings("unchecked")
	@Override
	public void clear() {
		queue = (T[]) new Object[DEFAULT_CAPACITY]; // Reinitializes the queue with the default capacity
		numberOfEntries = 0; // Sets the number of entries to zero to reflect the cleared array
	}

}
