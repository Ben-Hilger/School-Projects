import java.util.Scanner;

public class Tester {

	public static void main(String[] args) {
		
		Scanner scan = new Scanner(System.in);
		
		// Asks the user for the infix expression
		System.out.print("Infix Expression: ");
		String infixStr = scan.nextLine();
		
		// Asks the user the type of operation that they desired to be performed
		System.out.print("Enter 1 to get postfix expression, 2 to evaluate postfix expression and 3 to directly evaluate the infix expression: ");
		int selection = scan.nextInt();
		
		// Attempts to create an InfixExpression object with the string, reports to the user if the given expression is invalid
		InfixExpression infix; // Stores the infix expression
		try {
			infix = new InfixExpression(infixStr);
		} catch (IllegalArgumentException ex) {
			System.out.println("Fail: Invalid Expression"); // InfixExpression threw an error, and it reports the issue to the user
			return; // Stops the program
		}
				
		switch(selection) {
		case 1:
			System.out.println(infix.getPostfixExpression()); // Prints the postfix expression to the user
			break;
		case 2:
			System.out.println(infix.getPostfixExpression()); // Prints the postfix expression to the user
			System.out.println(infix.evaluatePostfix()); // Evaluates the postfix expression and reports the answer to the user
			break;
		case 3:
			System.out.println(infix.evaluate()); // Evaluates the infix expression and reports  the answer to the user
			break;
		default:
			System.out.println("Invalid Selection"); // Informs the user they picked an invalid selection
			break;
		}
		
	}
	
}
