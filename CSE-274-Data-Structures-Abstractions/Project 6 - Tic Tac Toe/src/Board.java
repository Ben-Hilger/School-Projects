
public class Board {

	
	// Stores the spaces in the board
	private char[] board;

	/**
	 * Creates a board reference with the specified board
	 * @param b The string containing the configuration of the board
 	 */
	public Board(String b) {
		
		double sq = Math.sqrt(b.length());
				
		// Checks if the board is a perfect square
		if((sq - Math.floor(sq)) == 0) {
			
			// Creates a new board with the specified length
			board = new char[b.length()];
			
			// Fills the board with the specified configuration
			for(int i = 0; i < b.length(); i++) {
				board[i] = b.charAt(i);
			}

		} else {
			
			// Throws an error to the user since the board isn't legal
			throw new IllegalArgumentException("Board must be a perfect square.");
		}
		
		
		
	}
	
	/**
	 * Gets the number of total spaces available on the board, ignoring if the space is empty or not
	 * @return The number of spaces on the board
	 */
	public int getNumberOfSpaces() {
		return board.length;
	}
	
	/**
	 * Gets the size of the side of the Tic Tac Toe board
	 * @return The size of the Tic Tac Toe board as an int
	 */
	public int getSquareSize() {
		return (int) Math.sqrt(board.length);
	}
	
	/**
	 * Gets the character at the specified index
	 * @param loc The index of the board
	 * @return The character at the specified index
	 */
	public char get(int loc) {
		return board[loc];
	}

	/**
	 * Calculates the number of occurrences of the given character
	 * @param c The character to search
	 * @return The number of occurrences of the given characters as an int
	 */
	public int getNumberOf(char c) {
		// Stores the number of occurrences
		int num = 0;
		
		// Explores every board position
		for(int i = 0; i < board.length; i++) {
			// Checks to see if the given board position is equal to the desired character
			if(board[i] == c) {
				num++; // Increases the counter
			}
		}
		
		// Returns the number of occurrences to the user
		return num;
	}
	
	/**
	 * Attempts to place the given character at the specified index on the board
	 * @param c The character to make the move
	 * @param index The index of the board where to make the move
	 * @return True if the move is valid and was made, false otherwise
	 */
	public boolean makeMove(char c, int index) {
		
		// Checks to make sure the given index is empty and within the bounds of the board
		if(!isEmptySpace(index) || (index < 0 || index >= board.length)) {
			return false;
		}
		
		// Sets the character to the given index
		board[index] = c;
		
		// Returns a success
		return true;
	}
	
	/**
	 * Sets the given board index to empty ('-')
	 * @param index The index on the board
	 */
	public void setSpaceToEmpty(int index) {
		
		// Ensures the given index is within the bounds of the board
		if(index < 0 || index >= board.length) {
			return;
		}
		
		// Sets the given index to empty
		board[index] = '-';
		
	}
	
	/**
	 * Checks to see if the given board index is empty ('-')
	 * @param space The board index to check
	 * @return True if the board index is empty, false otherwise
	 */
	public boolean isEmptySpace(int space) {
		return (space >= 0 && space < board.length) && board[space] == '-';
	}
	
	/**
	 * Checks if the board is full, which means there are no empty spaces
	 * @return True if the board is full, false otherwise
	 */
	public boolean isBoardFull() {
		
		// Explores every board position
		for(int i = 0; i < board.length; i++) {
			// Checks if the given space is empty
			if(board[i] == '-')
				return false;
		}
		
		// Since no empty spaces were found, it's full 
		return true;
		
	}


	/**
	 * Draws the board to the console
	 */
	public void drawBoard() {
		
		// Explores every row and column to print the board to represent a Tic Tac Toe board
		for(int i = 0; i < this.getSquareSize(); i++) {
			System.out.print(" ");
			for(int i2 = 0; i2 < this.getSquareSize(); i2++) {
				System.out.print(this.get(i2 + (this.getSquareSize() * i)) + (i2 < this.getSquareSize()-1 ? " | " : "" ));
			}
			
			System.out.println();
			
			for(int i2 = 0; i2 < this.getSquareSize(); i2++) {
				System.out.print("---");
			}
			
			System.out.println("-");
			
		}

	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		
		result = prime * result + toString().hashCode();
		
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if(obj == null) {
			return false;
		}
			
		return this.toString().contentEquals(((Board) obj).toString());
	
	}
	
	@Override
	public String toString() {
		
		String s = "";
		
		for(int i = 0; i < board.length; i++) {
			s += "" + board[i];
		}
		
		return s;
	}
	
}
