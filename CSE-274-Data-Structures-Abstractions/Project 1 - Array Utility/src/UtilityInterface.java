
public interface UtilityInterface<T> {

	/**
	 * Removes all the elements from the array
	 */
	public void clear();

	/**
	 * Gets the current number of elements in the array
	 * 
	 * @returns An integer, number of elements currently in the array
	 */
	public int getCurrentSize();
	
	
	/**
	 * Checks whether the array is empty
	 * 
	 * @returns True if the array is empty (has no elements), and false otherwise
	 */
	public boolean isEmpty();
	
	/**
	 * Checks whether the array has the specifie element
	 * 
	 * @returns True if the array contains anElement, and false otherwise
	 */
	public boolean contains(T anElement);
	
	/** 
	 * Gets the object at the specified index
	 * 
	 * @param index - An integer index of the array
	 * @return The objects specified at the specified index if it is a valid index, and null otherwise 
	 */
	public T get(int index);
	
	/**
	 * Gets the index of the first occurance of the specified element in the array
	 * 
	 * @param anElement - The given object (element)
	 * @return An integer, index in the array if found, and -1 otherwise
	 */
	public int indexOf(T anElement);
	
	/**
	 * Finds the frequency of a given element
	 * 
	 * @param anElement The given object (element)
	 * @return The total number of times the given object is in the array[
	 */
	public int getFrequencyOf(T anElement);
	
	/**
	 * Adds an element to the first available location/index of the array
	 *
	 * @param anElement - The element to add to the array
	 * @return True, if it can add the element to the array. False, otherwise
	 */
	boolean add(T anElement);
	
	/**
	 * Adds an element to the specified location/index of the array. If it is already occupied then shift the elements to the right by one
	 * position and add the new element. If the index is greater than the number of elements currently in the array then don't add and return false
	 *
	 * @param anElement - The element to add to the array
	 * @param index - The index or location to add the element
	 * @return True, if it can add the element to the array. False, otherwise
	 */
	boolean add(T anElement, int index);
	
	/**
	 * Removes the first occurance of the specified element. If it is not the last element then all of the elements after 'index'
	 * to the left by one position to make sure there's no empty spaces
	 * 
	 * @param anElement - The element to remove from the array
	 * @return True, if it can remove the element from the array. False, otherwise
	 */
	boolean remove(T anElement);
	
	/**
	 * Removes the first element from the array if there is any. Shifts all of the elements from the second index to the left by one position
	 * to make sure there is no empty space between the elements.
	 * 
	 * @return
	 */
	boolean removeFirst();
	
	/**
	 * Removes the last element from the array if there is any. Make sure that there are no empty spaces between the elements.
	 * 
	 * @return True, if it can remove the last element from the array. False, otherwise
	 */
	boolean removeLast();
	
	/**
	 * Removes the middle element from the array if there is any. If even, then the position will be determined by 
	 * (number of elements-1)/2. Shifts all elements after the index to the left by one position to make sure that there
	 * is no empty space between the elements
	 * 
	 * @return True, if it can remove the middle element from the array, false otherwise
	 */
	boolean removeMiddle();
	
	/**
	 * 	Reverses the current order of the elements in the array
	 */
	void reverse();
	
	
	
}
