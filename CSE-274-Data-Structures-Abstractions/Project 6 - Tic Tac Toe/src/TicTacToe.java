
public class TicTacToe {

	
	// Stores all of the possible boards and the best moves associated with each
	public HashedDictionary<Board, Integer> gameDictionary = new HashedDictionary<>();
	
	// Stores the game board
	private Board gameBoard;
	
	/**
	 * Creates a Tic Tac Toe game with the specified board
	 * @param b The board of the Tic Tac Toe game
	 */
	public  TicTacToe(Board b) {
		gameBoard = b; // Stores the specified board in the variable
		// Generates all possible boards with the one specified
		generateBoards(b, b.getNumberOfSpaces(), true);
	}
	
	/**
	 * Ensures that a given board is a valid Tic Tac Toe board, which must satisfy the following:
	 * There must be an equal amount of X's and O's or one more X than O
	 * They both can't have three in a row
	 * @param b The board to test
	 * @return true if the board is valid, false otherwise
	 */
	public boolean isValidBoard(Board b) {
		
		int numberOfX = b.getNumberOf('X'); // Stores the number of occurrences of X
		int numberOfO = b.getNumberOf('O'); // Stores the number of occurrences of O
		
		// Checks to make sure there's an equal number of X's and O's or there's only one X than O
		if(numberOfX == numberOfO || numberOfX-1 == numberOfO) {
			return !(doesHaveThreeInARow(b, 'X') && doesHaveThreeInARow(b, 'O')); // Returns true if they both don't have three in a row
		} else {
			return false; // The board violated the rules so it's not valid
		}
		
	}
	
	/**
	 * Indicates if the Tic Tac Toe game is over, which means:
	 * 1. The player or computer has three in a row
	 * OR
	 * 2. The board is full so no more moves can be made
	 * @return true if the game is over, or if the board is full and no more moves can be made
	 */
	public boolean isGameOver() {
		return hasAWinner() || gameBoard.isBoardFull();
	}
	
	/**
	 * Checks if the given board has a winner, which means that X or O has three in a row
	 * @param b The board to check
	 * @return True if the board has a winner as specified above,  false otherwise 
	 */
	public boolean hasAWinner() {
		return doesHaveThreeInARow(gameBoard, 'O') || doesHaveThreeInARow(gameBoard, 'X');
	}
	
	/**
	 * Checks if the board is a draw, which means:
	 * 1. The board is full
	 * 2. Neither X or O has three in a row
	 * @param b The board to check
	 * @return True if the conditions above are satisfied, false otherwise
	 */
	public boolean isADraw() {
		return !hasAWinner() && gameBoard.isBoardFull();
	}
	
	/**
	 * Checks to see if the player win, which means:
	 * X has three in a row
	 * @param b The board to check
	 * @return True if the player won, false otherwise
	 */
	public boolean playerWin() {
		return doesHaveThreeInARow(gameBoard, 'X');
	}
	
	/**
	 * Checks to see if the given character has three in a row on a given board
	 * @param b The board to check
	 * @param c The character to check if it has three in a row
	 * @return True if the given character has three in a row, false otherwise
	 */
	public boolean doesHaveThreeInARow(Board b, char c) {
		
		char current = '-'; // Stores the most recent character found
		int count = 0; // Stores the number of sequential occurrences of the current character
		
		String board = b.toString(); // Stores the board as a string for analysis
		
		// Explores each space in the board looking for a horizontal three in a row
		for(int i = 0; i < board.length(); i += b.getSquareSize()) {
			for(int i2 = i; i2 < i + b.getSquareSize() && i2 < board.length(); i2++) {
				// Checks if the current character is the same as the previous one
				if (current == board.charAt(i2)) {
					count++; // Increases the counter
					// Checks if the current equals the desired character and the count is greater than or equal to the square size, indicating a win
					if(current == c && count >= b.getSquareSize()) {
						return true;
					}
				} else {
					// A new character was found breaking the chain
					count = 1; // Resets the counter
					current = board.charAt(i2); // Set the current to the new character
				}
			}
			
			// Resets the counter and current for the next row
			count = 0;
			current = '-';
			
		}
		
		// Resets the counter and current to check for vertical wins
		count = 0;
		current = '-';
		
		// Explores each space in the board looking for a vertical three in  a row
		for(int i = 0; i < b.getSquareSize(); i++) {
			for(int i2 = i; i2 < board.length(); i2 += b.getSquareSize()) {
				// Checks if the current character is the same as the previous one
				if (current == board.charAt(i2)) {
					count++; // Increases the counter
					// Checks if the current equals the desired character and the count is greater than or equal to the square size, indicating a win
					if(current == c && count >= b.getSquareSize()) {
						return true;
					}
				} else if(current != board.charAt(i2)) {
					// A new character was found breaking the chain
					count = 1; // Resets the counter
					current = board.charAt(i2); // Sets the current to the new character
				}
			}

			// Resets the counter and current for the next column
			count = 0;
			current = '-';
		}
		
		
		// Resets the counter and current to check for a left diagonal win
		count = 0;
		current = '-';
		
		// Explores each space in the board checking for a left diagonal win
		for(int i = 0; i < board.length(); i += b.getSquareSize()+1) {
			// Checks if the current character is the same as the previous one
			if (current == board.charAt(i)) {
				count++; // Increases the current one
				// Checks if the current equals the desired character and the count is greater than or equal to the square size, indicating a win
				if(current == c && count >= b.getSquareSize()) {
					return true;
				}
			} else if(current != board.charAt(i)) {
				// A new character was found breaking the chain
				count = 1; // Resets the counter
				current = board.charAt(i); // Sets the current to the new character
			}
		}
		
		// Resets the counter and current to check for a right diagonal win
		count = 0;
		current = '-';
		
		// Explores each space in the board checking for a right diagonal win
		for(int i = b.getSquareSize()-1; i < board.length()-1; i += b.getSquareSize()-1) {
			// Checks if the current character is the same as the previous one
			if (current == board.charAt(i)) {
				count++; // Increases the current one
				// Checks if the current equals the desired character and the count is greater than or equal to the square size, indicating a win
				if(current == c && count >= b.getSquareSize()) {
					return true;
				}
			} else if(current != board.charAt(i)) {
				// A new character was found breaking the chain
				count = 1; // Resets the counter
				current = board.charAt(i); // Sets the current to the new character
			}
		}
		
		// There was no valid wins so it returns false
		return false;
	}
	
	/**
	 * Creates all possible boards and populates the gameDictionary with all valid boards and the best move for the next person to make
	 * @param b The board to create 
	 * @param numEmptySpaces The number of empty boards the board has
	 * @param move Who's turn to make a move, true means player and false means computer
	 */
	public void generateBoards(Board b, int numEmptySpaces, boolean move) {
		
		// Checks if there's still space to make a move
		if(numEmptySpaces == 0) {
			return; // Since there are no empty spaces left, return
		}
				
		// It explores all of the spaces on the board to make every possible board configuration
		for(int i = 0; i < b.getNumberOfSpaces(); i++) {
			// Checks if the current space being explored is empty
			if(b.isEmptySpace(i)) {
			
				// Checks to see who's turn it is
				if(move) {
					b.makeMove('X', i); // Since it's the players turn, it puts a X in that spot
				} else {
					b.makeMove('O', i); // Since it's the computers turn, it puts a O in that spot  
				}
				
				// Checks if the board is valid
				if(isValidBoard(b)) {
					//If its valid it adds it to the game dictionary and sets the value to the best move for the next person to make
					gameDictionary.add(new Board(b.toString()), findBestMove(b));
				}
				
				// Recursively generates all other possible configurations
				generateBoards(b, numEmptySpaces-1, !move);
				// Resets the space to setup the board for the next loop
				b.setSpaceToEmpty(i);

			}
			
			
		}
	}
	
	/**
	 * Finds the best move for the next person to make based on the current configuration of the board
	 * @param b The board to find the best move on 
	 * @return The board position where to make the move
	 */
	public int findBestMove(Board b) {
		
		// Checks if the board is full
		if(b.isBoardFull())
			return 0; // Returns 0 since there's no possible move to make
		
		// Finds out who's turn it is based on the number of X's and O's currently on the board
		char whosTurn = b.getNumberOf('X') > b.getNumberOf('O') ? 'O' : 'X';
		// Gets the opponent based on who's turn it is
		char opponent = whosTurn == 'X' ? 'O' : 'X';
		
		// Creates a temporary board reference to play out scenarios
		Board tempBoard = new Board(b.toString());
		
		// Explores the board looking for a possibility to win on this move
		for(int i = 0; i < b.getNumberOfSpaces(); i++) {
			
			// Checks to see if this move is valid and causes a win
			if(tempBoard.makeMove(whosTurn, i)) {
				// Checks to see if this move causes a win
				if(doesHaveThreeInARow(tempBoard, whosTurn)) {
					return i; // Returns the board index to the client
				} else {
					// Resets the move
					tempBoard.setSpaceToEmpty(i);
				}
			} 
		
		}
		
		// Resets the tempBoard to ensure accuracy
		tempBoard = new Board(b.toString());
		
		// Explores the board looking for a chance to stop the opponent from winning
		for(int i = 0; i < b.getNumberOfSpaces(); i++) {
			
			// Checks to see if this move is valid and causes a win
			if(tempBoard.makeMove(opponent, i)) {
				// Checks to see if this move causes a win
				if(doesHaveThreeInARow(tempBoard, opponent)) {
					return i; // Returns the board index to the client
				} else {
					// Resets the move
					tempBoard.setSpaceToEmpty(i);
				}
			} 			
		}
		
		// Resets the tempBoard to ensure accuracy
		tempBoard = new Board(b.toString());
		
		// Explores the board looking two steps ahead to see if it could win 
		for(int i = 0; i < b.getNumberOfSpaces(); i++) {
			
			// Checks to see if its a valid move
			if(tempBoard.makeMove(whosTurn, i)) {
				
				// Explores the board again looking to see if another move would cause a win
				for(int i2 = 0; i2 < b.getNumberOfSpaces(); i2++) {
					
					// Checks to see if its a valid move
					if(tempBoard.makeMove(whosTurn, i2)) {
					
						// Checks to see if this move results in a win
						if(this.doesHaveThreeInARow(tempBoard, whosTurn)) {
							return i; // Returns the board index of the first move made to the client 
						}
						
						// Resets the move
						tempBoard.setSpaceToEmpty(i2);
					
					}	
					
				}
				
				// Resets the move
				tempBoard.setSpaceToEmpty(i);
			
			}
			
			
		}
		
		// Checks if the middle of the board is empty
		if(b.isEmptySpace(4)) {
			return 4; // Returns the middle index to the user
		} else {
			// If the middle is occupied, it explores the board until it finds the first empty space
			for(int i = 0; i < b.getNumberOfSpaces(); i++) {
				if(b.isEmptySpace(i)) {
					return i; // Returns the index to the user
				}
			}
		}
		
		return 0;
	}
	
	/**
	 * Returns the index of the board indicating the best move from the dictionary
	 * @param s The board represented as a string
	 * @return The value from the dictionary indicating the best move
	 */
	public int getBestMove(String s) {
		
		// Stores the board in a temporary variable
		Board b = new Board(s);
		
		// Checks to see if the board exists in the gameDictionary
		if(gameDictionary.contains(b)){
			// Returns the value to the user
			return gameDictionary.getValue(new Board(s)); 
		} else {
			// Returns 0 if board doesn't exist
			return 0; 
		}
	}
	
}
