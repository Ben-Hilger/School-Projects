
public class Book {

	private String title; // Stores the title of the book
	private String author; // Stores the author of the book
	
	/**
	 * Initializes the book with the data specified
	 * 
	 * @param title The title of the book
	 * @param author The author of the book
	 */
	public Book(String title, String author) {
		this.title = title;
		this.author = author;
	}
	
	/**
	 * Returns the current title of the book
	 * 
	 * @return The title of the book as a String
	 */
	public String getTitle() {
		return title;
	}
	
	/**
	 * Sets the title of the current book to the one specified
	 * 
	 * @param newTitle The new title of the book
	 */
	public void setTitle(String newTitle) {
		title = newTitle;
	}
	
	/**
	 * Returns the current author of the book
	 * 
	 * @return The name of the author as a String
	 */
	public String getAuthor() {
		return author;
	}
	
	/**
	 * Sets the author of the current book to the one specified
	 * 
	 * @param newAuthor The new author of the book
	 */
	public void setAuthor(String newAuthor) {
		author = newAuthor;
	}
	
	/**
	 * Returns the string representation of the book as formatted: [title] by [author]
	 * 
	 * @return The string representation of the book
	 */
	public String toString() {
		return title + " by " + author;
	}
	
	/**
	 * Compares this book with the one specified to see if they have the same author and title
	 * 
	 * @param anotherBook The book to compare to this book
	 * @return True if the books are the same, false otherwise
	 */
	public boolean equals(Book anotherBook) {
		return title.equals(anotherBook.getTitle()) && author.equals(anotherBook.getAuthor());
	}
	
}
