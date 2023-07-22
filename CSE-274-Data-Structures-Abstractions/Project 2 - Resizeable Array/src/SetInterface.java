/**
 * An interface that describes the operations of a set of books.  Created by Carrano, Henry, Hoot.
 * Modified a lot by Norm Krumpe and Md Osman Gani
 * 
 * @author Frank M. Carrano
 * @author Timothy M. Henry
 * @author Charles Hoot
 * @version 5.0
 */
public interface SetInterface {
	/**
	 * Gets the current number of entries in this set.
	 * 
	 * @return The integer number of entries currently in the set.
	 */
	public int getSize();

	/**
	 * Sees whether this set is empty.
	 * 
	 * @return True if the set is empty, or false if not.
	 */
	public boolean isEmpty();

	/**
	 * Adds a new entry to this set, avoiding duplicates.
	 * 
	 * @param newBook
	 *            The book to be added as a new entry.
	 * @return True if the addition is successful, or false if the item already
	 *         is in the set.
	 */
	public boolean add(Book newBook);

	/**
	 * Removes a specific entry from this set, if possible.
	 * 
	 * @param aBook
	 *            The entry to be removed.
	 * @return True if the removal was successful, or false if not.
	 */
	public boolean remove(Book aBook);

	/**
	 * Removes one unspecified entry from this set, if possible.
	 * 
	 * @return Either the removed entry, if the removal was successful, or null.
	 */
	public Book remove();

	/** Removes all entries from this set. */
	public void clear();

	/**
	 * Tests whether this set contains a given entry.
	 * 
	 * @param aBook
	 *            The entry to locate.
	 * @return True if the set contains anEntry, or false if not.
	 */
	public boolean contains(Book aBook);

	/**
	 * Computes the union of this set with a given set
	 * 
	 * @param anotherSet
	 *            another set
	 * @return the union of this set with anotherSet
	 */
	public SetInterface union(SetInterface anotherSet);
	
	/**
	 * Computes the intersection of this set with a given set
	 * 
	 * @param anotherSet
	 *            another set
	 * @return the intersection of this set with anotherSet
	 */
	public SetInterface intersection(SetInterface anotherSet);
	
	/**
	* Computes the elements in this set except for those that are also in anotherSet
    *
	* @param anotherSet
	*            another set
	* @return the result of removing all elements of this set that are in anotherSet
	*/
	public SetInterface difference(SetInterface anotherSet);

	/**
	 * Retrieves all entries that are in this set.
	 * 
	 * @return A newly allocated array of all the entries in the set, where the
	 *         size of the array is equal to the number of entries in the set.
	 */
	public Book[] toArray();
} // end SetInterface
