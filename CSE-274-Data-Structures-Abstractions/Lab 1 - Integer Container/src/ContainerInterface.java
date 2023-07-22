
public interface ContainerInterface<T> {
	/**
	 * @return The current size of the container
	 */
	public int getCurrentSize();
	/**
	 * @return True if the container is empty, false otherwise
	 */
	public boolean isEmpty();
	/**
	 * Attempts to add the specified object to the container
	 * @param newObject The object to add to the container
	 * @return True if the container is added succesfully, false otherwise
	 */
	public boolean add(T newObject);
	/**
	 * Attempts to remove the specified object from the container
	 * @param anObject The object to remove
	 * @return True if it was found and removed, false otherwise
	 */
	public boolean remove(T anObject);
	/**
	 * Attempts to find the specified object in the container
	 * @param anObject The object to find
	 * @return True if the object is found, false otherwise
	 */
	public boolean contains(T anObject);
	
}
