import java.util.Arrays;

/**
 * All of the enclosed methods and implementations 
 * worked according to their intended purpose
 */

public class ResizableArraySet implements SetInterface {
	
	private Book[] bookEntries;
	private int numberOfEntries;
	
	
	/**
	 *  Creates an array with a capacity of 10
	 */
	public ResizableArraySet() {
		bookEntries = new Book[10];
		numberOfEntries = 0;
	}
	
	/**
	 * Creates an array with the specified beginning capacity
	 * @param capacity The initial capacity of the array
	 */
	public ResizableArraySet(int capacity) {
		bookEntries = new Book[capacity];
		numberOfEntries = 0;
	}
	
	@Override
	public int getSize() {
		return numberOfEntries; // Returns the number of entries
	}

	@Override
	public boolean isEmpty() {
		return numberOfEntries == 0; // Returns true if there's isn't current entries (numberOfEntries is 0), false otherwise
	}

	@Override
	public boolean add(Book newBook) {

		// Checks to see if the array is full
		if(numberOfEntries >= bookEntries.length) {
			bookEntries = Arrays.copyOf(bookEntries, bookEntries.length * 2); // Doubles the  length of the array, conserving its contents
		}
		
		bookEntries[numberOfEntries] = newBook; // Puts the reference of the new book in the next available slot
		numberOfEntries++; // Increments the number of entries by one to reflect the new book
		
		return true;
	}

	@Override
	public boolean remove(Book aBook) {

		// Explores the data to find  the specified book
		for(int i = 0; i < numberOfEntries; i++) {
			// Checks to see if the book at the index is equal to the specified book
			if(bookEntries[i].equals(aBook)) {
				
				numberOfEntries--; // Decreases the number of entries by one to reflect the removal of the book
				bookEntries[i] = bookEntries[numberOfEntries]; // Replaces the book being removed by the book at the end to ensure no empty spaces in the array
				bookEntries[numberOfEntries] = null; // Sets the book at the end to null
				
				// Checks to see if the current number of elements is less than or equal to 1/3 the total size of the array
				if(numberOfEntries <= bookEntries.length/3) {
					bookEntries = Arrays.copyOf(bookEntries, bookEntries.length/2); // Removes unnecessary space by shrinking the array to  half of its size
				}
				
				return true;
			}
		}
		
		// The book wasn't found
		return false;
	}

	@Override
	public Book remove() {

		if(isEmpty()) {
			return null;
		}
		
		numberOfEntries--; // Decreases the number of entries by one to reflect a book being removed
		Book bookRemoved = bookEntries[numberOfEntries]; // Gets the book reference of the final book in the list to give to the user
		bookEntries[numberOfEntries] = null; // Removes the last book in the array
		
		return bookRemoved;
	}

	@Override
	public void clear() {
		bookEntries = new Book[bookEntries.length]; // Creates a new, empty array but maintains current size
		numberOfEntries = 0; // Resets the number of entries
	}

	@Override
	public boolean contains(Book aBook) {

		// Explores the data to see if one of the books contained within the array is the same as the one specified
		for(int i = 0; i < numberOfEntries; i++) {
			// Checks to see if the books are the same
			if(bookEntries[i].equals(aBook)) {
				return true;
			}
		}
		
		// It was unable to find a book that was the same
		return false;
	}

	@Override
	public SetInterface union(SetInterface anotherSet) {
		
		// Creates an empty list to put the union values
		SetInterface unionSet = new ResizableArraySet();
		
		// Explores the data of this set to add values not currently in the union array
		for(int i  = 0;  i < numberOfEntries; i++) {
			// Checks to see if the union already contains the book, ensuring no duplicates
			if(!unionSet.contains(bookEntries[i])) {
				unionSet.add(bookEntries[i]); // Adds the specified book to the union entry 
			}
		}
		
		// Explores the data of the specified second set to add values not currently in the union array
		for(int i  = 0;  i < anotherSet.getSize(); i++) {
			// Checks to see if the union already contains the book, ensuring no duplicates
			if(!unionSet.contains(anotherSet.toArray()[i])) {
				unionSet.add(anotherSet.toArray()[i]); // Adds the specified book to the union entry 
			}
		}
		
		return unionSet;
	}

	@Override
	public SetInterface intersection(SetInterface anotherSet) {
		
		// Creates an empty list to put the intersection values
		SetInterface interSet = new ResizableArraySet();
		
		// Explores the data of this set
		for(int i = 0; i < numberOfEntries; i++) {
			
			Book currentBook = bookEntries[i]; // The current book being explored
			
			// Checks to ensure the book isn't already in the interSet array and is contained in the second array
			if(!interSet.contains(currentBook) && anotherSet.contains(currentBook)) {
				interSet.add(currentBook); // Adds the current book to the interSet array
				
			}
			
		
		}
		
		return interSet;
	}

	@Override
	public SetInterface difference(SetInterface anotherSet) {
		
		// Creates an empty list to put the intersection values
		SetInterface diffSet = new ResizableArraySet();
		
		// Explores the data of this set
		for(int i = 0; i < numberOfEntries; i++) {
			
			Book currentBook = bookEntries[i]; // The current book being explored
		
			// Checks to ensure the book isn't already in the diffSet array and isn't contained in the second array
			if(!anotherSet.contains(currentBook) && !diffSet.contains(currentBook)) {
				diffSet.add(currentBook); // Adds the current book to the diffSet array
			}
		
		}
		
		// Explores the data of the other set
		for(int i = 0; i < anotherSet.getSize(); i++) {
			
			Book currentBook = anotherSet.toArray()[i]; // The current book being explored
		
			// Checks to ensure the book isn't already in the diffSet array and isn't contained in this array
			if(!contains(currentBook) && !diffSet.contains(currentBook)) {
				diffSet.add(currentBook); // Adds the current book to the diffSet array
			}
		
		}
		
		return diffSet;
	}

	@Override
	public Book[] toArray() {
		return Arrays.copyOf(bookEntries, numberOfEntries); // Returns a copy of the current book array with a length equal to the number of entries
	}

}
