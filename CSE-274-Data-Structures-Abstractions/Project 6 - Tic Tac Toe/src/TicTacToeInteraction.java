import java.util.Scanner;

public class TicTacToeInteraction {

	public static void main(String[] args) {
		
		
		Scanner scan = new Scanner(System.in);
		
		// Gets basic information from the player
		System.out.println("Hello and welcome to the tic tac toe game! In this game you'll be playing against a computer designed by Ben Hilger");
		System.out.print("To begin, please enter your first name: ");
		String firstName = scan.nextLine();
		System.out.print("Now please enter your last name: ");
		String lastName = scan.nextLine();
	
		Name player = new Name(firstName, lastName);
		
		System.out.println("Welcome " + player.getName() + "! Please wait one second while we setup your game\n");
		
		// Sets up the game
		Board gameBoard = new Board("---------");
		TicTacToe game = new TicTacToe(gameBoard);
					
		// Builds the board that will show what numbers to enter for which space
		String s = "";
		int min = 1;
		int max = -1;
		for(int i = 1; i <= gameBoard.getNumberOfSpaces(); i++) {
			s += i;
			min = Math.min(min, i);
			max = Math.max(i, max);
		}
		
		// Draws the board to the console
		(new Board(s)).drawBoard();

		// Runs the game
		while(!game.isGameOver()) {
			
			System.out.println("\nCurrent Board: \n");
			gameBoard.drawBoard();
			
			// Player goes first
			int val = 1;
			boolean turnOver = false;
			do {
				System.out.print("\nPlease enter a number between " + min + "-" + max + " to indicate where you would like to play as indicated above:");
				val = scan.nextInt();
				
				if(gameBoard.makeMove('X', val-1)) {
					turnOver = true;
				} else {
					System.out.println("Space already occupied");
				}
				
			} while(!turnOver);
			
			if(!game.isGameOver())
				gameBoard.makeMove('O', game.getBestMove(gameBoard.toString()));
			
		}
		
		System.out.println("\nFinal Board: \n");
		gameBoard.drawBoard();
		
		if(game.isADraw()) {
			System.out.println("\nIt's a draw! Thanks for playing!");
		} else if(game.hasAWinner()) {
			System.out.println(game.playerWin() ? "X wins!!!!" : "O wins!!!!");
			if(game.playerWin()) {
				System.out.println("\nCongratulations " + player.getName() + " you've won!! Thanks for playing!!" );
			} else {
				System.out.println("\nSorry " + player.getName() + " but you lost. Thanks for playing!!" );

			}	
		}
	}
	
	
	
}
