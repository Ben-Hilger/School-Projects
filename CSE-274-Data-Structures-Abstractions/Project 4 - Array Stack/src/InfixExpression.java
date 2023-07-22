import java.util.EmptyStackException;

public class InfixExpression {

	private String infix;
	
	/**
	 * Initializes an InfixExpression with the given expression
	 * 
	 * @param i The infix expression to be  stored
	 * @throws IllegalArgumentException if the expression given is invalid
	 */
	public InfixExpression(String i) {
		
		infix = i;
		clean(); // Cleans up the infix so that way it's formatted properly for all methods
				
		// Checks if the given infix is valid, throws an error to report to the user if it isn't
		if(!isValid()) {
			throw new IllegalArgumentException(); // Throws an exception to the user to report they entered an invalid infix
		}
		 		
	}
	
	/**
	 * Gives the user the cleaned infix expression
	 * 
	 * @return The infix expression as a String
	 */
	public String toString() {
		return infix;
	}
	
	/**
	 * Checks if the given infix expression has an equal amount of opening and closing parentheses
	 * 
	 * @return True if the equation has a balanced number of open and closing parentheses, false otherwise
	 */
	private boolean isBalanced() {
		
		// Initializes a stack to store the open parentheses
		ArrayStack<Character> isBalStack = new ArrayStack<>();
		
		// Reports if the  equation is balanced or not
		boolean isBalanced = true;
		
		// Explores each character in the string
		for(int i = 0; i < infix.length(); i++) {
			char curr = infix.charAt(i); // Gets the current character being explored
			
			// Explores the current character
			switch(curr) {
			// Checks to see if the character is an open parentheses
			case '(': case '[': case '{':
				isBalStack.push(curr); // Adds the open parentheses to the balance stack
				break;
			// Checks to see if the character is a close parentheses
			case ')': case ']': case '}':
				// Checks if the balance stack is empty, indicating an unbalanced expression
				if(isBalStack.isEmpty()) {
					isBalanced = false; // Sets isBalanced isFalse to indicate an unbalanced expression
				} else {
					char top = isBalStack.pop(); //  Gets the top operator from the balance stack
					
					// Checks to see if the given open parentheses pairs with the closing parentheses, and sets isBalanced to true if that is true and false otherwise
					isBalanced = (top == '(' && curr == ')') ? true
							: (top == '[' && curr ==  ']') ? true
							:  (top == '{' && curr  == '}') ? true
							: false;
							
				}
				break;
			default:
				break; // Ignore unexpected characters
			}
		}
		
		// Checks to see if there are still elements in the balance stack
		if(!isBalStack.isEmpty()) { 
			isBalanced = false; // Sets isBalanced to false since it's unbalanced
		}
		
		return isBalanced;
		
	}
	
	/**
	 * Checks to see if the given infix expression is valid, in order to be valid it mustxw:
	 * Contain only valid characters: 0-9, +, -, /, *, %, ^, (, )
	 * Parentheses must be balanced
	 * Valid order of operators and operands
	 * 
	 * @return True if the infix expression is valid, false otherwise
	 */
	private boolean isValid() {
		
		// Simulates evaluating the given infix, This will allow to test for proper order of operators and operands and for valid characters
		
		ArrayStack<Character> operatorStack = new ArrayStack<>(); // Creates an operator stack to store operators
		ArrayStack<Integer> valueStack = new ArrayStack<>(); // Creates a value stack to store operands
		
		// Explores each character of the infix string
		for(int i = 0; i < infix.length(); i++) {
			char nextChar = infix.charAt(i); // Gets the current character being explored
			
			switch(nextChar) {
			case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9': // Checks if the character is a variable
				String num = "" + nextChar; // Creates a string to hold the number
				
				// Explores the infix string until the end or when it finds a string that's not a digit
				while(i+1 < infix.length() && Character.isDigit(infix.charAt(i+1))) {
					i++; // Increments i since it's a digit and being added to the num string
					nextChar = infix.charAt(i); // Gets the digit to be added
					num += nextChar; // Adds the digit to the number string
				}
				
				valueStack.push(Integer.parseInt(num)); // Pushes the number to the value stack
				
				break;
			case '^':
				operatorStack.push(nextChar); // Pushes the exponent to the operator stack
				break;
			case '+': case '-': case '/': case '*': case '%':
				// Explores the operators until the stack is empty or the next operator has a lower precedence than the current one being explored
				while(!operatorStack.isEmpty() && this.getPrecedence(nextChar) <= this.getPrecedence(operatorStack.peek())) {
					// Tries to get the next set of operator and operands
					char topOp; // Stores the top operator
					int operandTwo; // Stores the top value in the stack 
					int operandOne; // Stores the next value in the stack
					try {
						topOp = operatorStack.pop(); // Gets the top operator in the stack
						operandTwo = valueStack.pop(); // Gets the top value in the stack 
						operandOne = valueStack.pop(); // Gets the next value in the stack
					} catch (Exception e) {
						return false; // Since an error was thrown, it's invalid and returns false
					}
					// Evaluates the result of the two operands based on the operator
					int result = (topOp == '+' ? operandOne + operandTwo : // Addition
							topOp == '-' ? operandOne - operandTwo : // Subtraction
							topOp == '/' ? operandOne / operandTwo : // Division
							topOp == '*' ? operandOne * operandTwo : // Multiplication
							topOp == '%' ? operandOne % operandTwo : // Modular
							topOp == '^' ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent
							);
					valueStack.push(result); // Pushes the result to the value stack
				}
				
				operatorStack.push(nextChar); // Pushes the current operator to the operator stack
				break;
			case '(':
				operatorStack.push(nextChar); // Pushes the parenthesis to the operator stack 
				break;
			case ')':
				char topOp;
				try {
					topOp = operatorStack.pop(); // Gets the current top operator from the operator stack
				} catch (Exception e) {
					return false; // Since an error was thrown, it's invalid
				}
		
				// Explores the operator and operands until it finds the corresponding closing parenthesis
				while(topOp != '(') {
					// Tries to get the next set of operands
					int operandTwo; // Stores the top value in the stack 
					int operandOne; // Stores the next value in the stack
					try {
						operandTwo = valueStack.pop(); // Gets the top value in the stack 
						operandOne = valueStack.pop(); // Gets the next value in the stack
					} catch (Exception e) {
						return false; // Since an error was thrown, it's invalid
					}
					// Evaluates the result of the two operands based on the operator
					int result = (topOp == '+' ? operandOne + operandTwo : // Addition
							topOp == '-' ? operandOne - operandTwo : // Subtraction
							topOp == '/' ? operandOne / operandTwo : // Division
							topOp == '*' ? operandOne * operandTwo : // Multiplication
							topOp == '%' ? operandOne % operandTwo : // Modular
							topOp == '^'  ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent

							);

					valueStack.push(result); // Pushes the result to the value stack
					topOp = operatorStack.pop(); // Gets the top operator in the operator stack
					break;
				}
			case ' ':
				break; // Since this is a valid character, do nothing
			default: 
				return false; // Since it reached here, it contains an illegal character and is invalid
			}
		}
		
		// Explores the operator stack until it's empty
		while(!operatorStack.isEmpty()) {
			// Tries to get the next set of operator and operands
			char topOp; // Stores the top operator
			int operandTwo; // Stores the top value in the stack 
			int operandOne; // Stores the next value in the stack
			try {
				topOp = operatorStack.pop(); // Gets the top operator in the stack
				operandTwo = valueStack.pop(); // Gets the top value in the stack 
				operandOne = valueStack.pop(); // Gets the next value in the stack
			} catch (Exception e) {
				return false; // Since an error was thrown it's invalid
			}
		
			int result = (topOp == '+' ? operandOne + operandTwo : // Addition 
					topOp == '-' ? operandOne - operandTwo : // Subtraction
					topOp == '/' ? operandOne / operandTwo : // Division
					topOp == '*' ? operandOne * operandTwo : // Multiplication
					topOp == '%' ? operandOne % operandTwo : // Modular
					topOp == '^'  ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent
					);
			valueStack.push(result); // Pushes the result to the value stack
		}
						
		// Since it's been determined the expression is valid, it checks if it's balanced and returns the result to the user
		return isBalanced();
		
	}
	
	/**
	 * Cleans the expression by ensuring there's one space between adjacent tokens, and no trailing or leading spaces
	 */
	private void clean() {
	
		String cleaned = ""; // Stores the cleaned string
		
		// Explores every character in the infix string
		for(int i = 0; i < infix.length(); i++) {
			
			char nextChar = infix.charAt(i); // Stores the current character being explored

			
			if(Character.isDigit(nextChar)) { // Checks if the character is a digit 
				cleaned += nextChar; // Adds the digit to the string
			} else if(nextChar == '+' || nextChar == '-' || nextChar == '*' || nextChar == '/' || nextChar == '%' || nextChar == '^') { // Checks if the character is an operator
				cleaned += " " + nextChar + " "; // Adds the operator, plus a space on each side, to the string
			} else if(nextChar == '(' || nextChar == '{' || nextChar == '[') { // Checks if the character is an open parenthesis
				cleaned += nextChar; // Adds the parenthesis, plus one space after, to the string
			} else if(nextChar == ')' || nextChar == '}' || nextChar == ']') { // Checks if the character is a closed parenthesis
				cleaned += nextChar; // Adds the parenthesis, plus on space on each side, to the string 
			} else if(nextChar != ' ') {
				cleaned += nextChar; // Adds all other non-space characters to the string
			}
			
		}
		
		infix = cleaned.trim(); // Sets infix to the cleaned string
	}
	
	/**
	 * Converts the given infix expression to the corresponding postfix expression
	 * 
	 * @return A string with the postfix expression that corresponds to the given infix expression
	 */
	public String getPostfixExpression() {
		
		ArrayStack<Character> operatorStack = new ArrayStack<>(); // Creates a stack that stores the operators
		String postFix = ""; // Creates an empty string to store the postfix expression
		
		// Explores each character of the infix expression
		for(int i = 0; i < infix.length(); i++) {
			char nextChar = infix.charAt(i); // Stores the current character being explored
		
			// Explores the current character
			switch(nextChar) {
			case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9': // Checks if the character is a variable
				postFix += nextChar; // Adds the digit to the postfix string
				break;
			case '^':
				operatorStack.push(nextChar); // Adds the operator to the operator stack
				postFix += " "; // Adds a space to the postfix string
				break;
			case '+': case '-': case '*': case '/': case '%': 
				
				// Explores the operatorStack until the stack is empty or the next operator has a lower precedence
				while(!operatorStack.isEmpty() && this.getPrecedence(nextChar) <= this.getPrecedence(operatorStack.peek())) {
					postFix += " " + operatorStack.peek(); // Adds the operator to the postfix
					operatorStack.pop();  // Removes the operator from the stack
					
				}
				operatorStack.push(nextChar); // Adds the operator to the stack
				postFix += " "; // Adds a space to the postfix string
				break;
			case '(': case '{': case '[':
				operatorStack.push(nextChar); // Adds the open parenthesis to the stack
				break;
			case ')': case '}': case ']':
				// Gets the corresponding closing parenthesis
				char equiv = nextChar == ')' ? '(' :
					nextChar == '}' ? '{' :
					nextChar == '[' ? ']' : ')';
				
				char topOp = operatorStack.pop(); // Gets the top operator from the stack
				
				// Explores the operators until it find the corresponding closing parenthesis
				while(topOp != equiv) {
					postFix += " " + topOp; // Adds the top operator to the postfix string
					topOp = operatorStack.pop(); // Gets the next operator from the stack
				}
				break;
			default: break; // Ignore unexpected characters
			}
			
		}

		postFix = postFix.trim(); // Trims to ensure no extra spaces on the end
		
		// Explores the operator stack until it's empty
		while(!operatorStack.isEmpty()) {
			char topOp = operatorStack.pop(); // Gets the top operator from the stack
			postFix += " " + topOp; // Adds the top operator to the postfix expression
		}
		
		return postFix.trim(); // Returns a trimed postfix to the user
	}
	
	/**
	 * Evaluates the postfix expression 
	 * 
	 * @return The result of the postfix expression as an integer
	 */
	public int evaluatePostfix() {
		
		ArrayStack<Integer> valueStack = new ArrayStack<>(); // Creates a stack that stores the values of the expression
		String postFix = this.getPostfixExpression(); // Gets the expression in postfix form
		
		// Explores each character of the postfix string
		for(int i = 0; i < postFix.length(); i++) {
			char nextChar = postFix.charAt(i); // Stores the current character being explored
			
			switch(nextChar) {
			case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9': // Checks if the character is a variable
				String num = "" + nextChar; // Creates a string to hold the number
				
				// Explores the postfix string until the end or when it finds a string that's not a digit
				while(i+1 < postFix.length() && Character.isDigit(postFix.charAt(i+1))) {
					i++; // Increments i since it's a digit and being added to the num string
					nextChar = postFix.charAt(i); // Gets the digit to be added
					num += nextChar; // Adds the digit to the number string
				}
				valueStack.push(Integer.parseInt(num)); // Pushes the number to the value stack
				
				break;
			case '+': case '-': case '*': case '/': case '^': case '%':
				
				// Gets the top two operands from the value stack
				int operandTwo = valueStack.pop();
				int operandOne = valueStack.pop();
			
				// Evaluates the result of the two operands based on the operator
				int result = (nextChar == '+' ? operandOne + operandTwo : // Addition
						nextChar == '-' ? operandOne - operandTwo : // Subtraction
						nextChar == '/' ? operandOne / operandTwo : // Division
						nextChar == '*' ? operandOne * operandTwo : // Multiplication
						nextChar == '%' ? operandOne % operandTwo : // Modular
						nextChar == '^' ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent
						);
				valueStack.push(result); // Pushes the result to the value stack
				break;
			default: break;
			}
		}
		return valueStack.peek(); // Returns the top value in the value stack
	}
	
	/**
	 * Directly evaluates the infix expression
	 * 
	 * @return The result of the calculation as an integer
	 */
	public int evaluate() {
		
		ArrayStack<Character> operatorStack = new ArrayStack<>(); // Creates an operator stack to store operators
		ArrayStack<Integer> valueStack = new ArrayStack<>(); // Creates a value stack to store operands
		
		// Explores each character of the infix string
		for(int i = 0; i < infix.length(); i++) {
			char nextChar = infix.charAt(i); // Gets the current character being explored
			
			switch(nextChar) {
			case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9': // Checks if the character is a variable
				String num = "" + nextChar; // Creates a string to hold the number
				
				// Explores the infix string until the end or when it finds a string that's not a digit
				while(i+1 < infix.length() && Character.isDigit(infix.charAt(i+1))) {
					i++; // Increments i since it's a digit and being added to the num string
					nextChar = infix.charAt(i); // Gets the digit to be added
					num += nextChar; // Adds the digit to the number string
				}
				
				valueStack.push(Integer.parseInt(num)); // Pushes the number to the value stack
				
				break;
			case '^':
				operatorStack.push(nextChar); // Pushes the exponent to the operator stack
				break;
			case '+': case '-': case '/': case '*': case '%':
				// Explores the operators until the stack is empty or the next operator has a lower precedence than the current one being explored
				while(!operatorStack.isEmpty() && this.getPrecedence(nextChar) <= this.getPrecedence(operatorStack.peek())) {
					char topOp = operatorStack.pop(); // Gets the top operator from the stack
					int operandTwo = valueStack.pop(); // Gets the top operand from the stack
					int operandOne = valueStack.pop(); // Gets the next operand from the stack
					
					// Evaluates the result of the two operands based on the operator
					int result = (topOp == '+' ? operandOne + operandTwo : // Addition
							topOp == '-' ? operandOne - operandTwo : // Subtraction
							topOp == '/' ? operandOne / operandTwo : // Division
							topOp == '*' ? operandOne * operandTwo : // Multiplication
							topOp == '%' ? operandOne % operandTwo : // Modular
							topOp == '^' ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent
							);
					valueStack.push(result); // Pushes the result to the value stack
				}
				
				operatorStack.push(nextChar); // Pushes the current operator to the operator stack
				break;
			case '(':
				operatorStack.push(nextChar); // Pushes the parenthesis to the operator stack 
				break;
			case ')':
				char topOp = operatorStack.pop(); // Gets the current top operator from the operator stack
		
				// Explores the operator and operands until it finds the corresponding closing parenthesis
				while(topOp != '(') {
					int operandTwo = valueStack.pop(); // Gets the top operand in the value stack
					int operandOne = valueStack.pop(); // Gets the next operand in the value stack
					
					// Evaluates the result of the two operands based on the operator
					int result = (topOp == '+' ? operandOne + operandTwo : // Addition
							topOp == '-' ? operandOne - operandTwo : // Subtraction
							topOp == '/' ? operandOne / operandTwo : // Division
							topOp == '*' ? operandOne * operandTwo : // Multiplication
							topOp == '%' ? operandOne % operandTwo : // Modular
							topOp == '^'  ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent

							);

					valueStack.push(result); // Pushes the result to the value stack
					topOp = operatorStack.pop(); // Gets the top operator in the operator stack
					break;
				}
			default: break;

			}
		}
		
		// Explores the operator stack until it's empty
		while(!operatorStack.isEmpty()) {
			char topOp = operatorStack.pop(); // Gets the top operator in the stack
			int operandTwo = valueStack.pop(); // Gets the top value in the stack 
			int operandOne = valueStack.pop(); // Gets the next value in the stack
			int result = (topOp == '+' ? operandOne + operandTwo : // Addition 
					topOp == '-' ? operandOne - operandTwo : // Subtraction
					topOp == '/' ? operandOne / operandTwo : // Division
					topOp == '*' ? operandOne * operandTwo : // Multiplication
					topOp == '%' ? operandOne % operandTwo : // Modular
					topOp == '^'  ? (int)Math.pow(operandOne, operandTwo) : 0 // Exponent
					);
			valueStack.push(result); // Pushes the result to the value stack
		}
				
		return valueStack.peek(); // Returns the top value in the stack to the user
	}
	
	/**
	 * Returns the number corresponding to the given precedence in terms of other operators
	 * 
	 * @param val The operator
	 * @return The precedence of the given value
	 */
	private int getPrecedence(char val) {
		switch(val) {
		case '+': case '-': // Addition and Subtraction
			return 3;
		case '*': case '/': case '%': // Multiplication, Division, Modularity
			return 4;
		case '^': // Exponent
			return 2;
		case '(': // Parenthesis
			return 1;
		default:
			return -1;
		}
	}
	
}
