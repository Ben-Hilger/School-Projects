import java.util.Arrays;
import java.util.EmptyStackException;

public class ArrayStack<T> implements StackInterface<T> {

	T[] stack;
	int size = 0;
	
	private static final int DEFAULT_CAPACITY = 10;
	
	@SuppressWarnings("unchecked")
	public ArrayStack() {
		
		stack = (T[])new Object[DEFAULT_CAPACITY]; // Creates a new stack with the default capacity
		
	}
	
	@Override
	public void push(T newEntry) {
		
		// Checks if there's space in the current stack
		if(size+1 >= stack.length) {
			stack = Arrays.copyOf(stack, stack.length*2); // There currently isn't enough space so it will double its size
		}
		
		stack[size] = newEntry; // Adds the new entry to the stack in the next available position
		size++; // Increases the size by one to reflect adding a new entry
		
	}

	@Override
	public T pop() {

		// Checks if the list is empty
		if(size == 0) {
			throw new EmptyStackException(); // Throws an exception to the user to report an empty stack
		} else {
			T value = stack[size-1]; // Stores the top item in a temporary variable
			stack[size-1] = null; // Removes the item from the stack
			size--; // Decreases the size to reflect removing an item
			
			return value; // Returns the value to the user
		}
	}

	@Override
	public T peek() {
				
		// Checks if the list is empty
		if(size == 0) {
			throw new EmptyStackException(); // Throws an exception to the user to report an empty stack
		} else {
			return stack[size-1]; // Returns the top item in the stack, keeping the contents the same
		}
	}

	@Override
	public boolean isEmpty() {
		return size == 0; // Returns true if the size is 0, false otherwise
	}

	@SuppressWarnings("unchecked")
	@Override
	public void clear() {
		stack = (T[])new Object[DEFAULT_CAPACITY]; // Resets the stack by replacing the current reference with a new one
		size = 0; // Sets size to 0 to reflect the clearing of the stack
	}
}
