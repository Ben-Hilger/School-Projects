/**
 * A binary tree implementation. When adding values to
 * a tree, there is no assumed "correct" location for that value.
 * So, we will give the root package access, so that we can manually
 * build our trees from a tester class.
 * 
 * @author Norm Krumpe
 *
 */

public class BinaryTree {
		
	Node root; // References the top most node, root, in the tree
	
	/**
	 * Creates an empty binary tree
	 */
	public BinaryTree() {
		root = null; // Sets the root node to null, creating an empty tree
	}
	
	/**
	 * Returns the height of this tree
	 * @return
	 */
	public int getHeight() {
		return getHeight(root);
	}
	
	private int getHeight(Node root) {
		
		// Checks to see if the root is null
		if(root == null) {
			return 0; // Returns that it's empty
		} else {
			// Traverses the left and right subtrees to get the height and only uses the max of the two
			return 1 + Math.max(getHeight(root.left), getHeight(root.right)); 	
		}
	}
	
	public int getNumberOfNodes() {
		return getNumberOfNodes(root);
	}
	
	private int getNumberOfNodes(Node root) {
		
		// Checks to see if the root is null
		if(root == null) {
			return 0;
		} else {
			// Traverses and gets the number of nodes in the left and right subtree
			return 1 + getNumberOfNodes(root.left) + getNumberOfNodes(root.right); 
		}
	}
	
	public int getNumberOfLeaves() {
		return getNumberOfLeaves(root); 
	}
	
	private int getNumberOfLeaves(Node root) {
		
		// Checks if the root is empty
		if(root == null) {
			return 0; // This is empty, which means it isn't a leaf and returns 0
		} 
		
		// Checks if both left and right references are null, indicating a leaf
		if(root.left == null && root.right == null) {
			return 1; // This is one leaf
		}
		
		// Traverses the left and right subtree looking for a leaf or a null node
		return getNumberOfLeaves(root.left) + getNumberOfLeaves(root.right); 
		
	}
	/**
	 * Prints the preorder traversal of this tree
	 */
	public void preorderTraversal() {
		preorderTraversal(root);
	}
	
	private void preorderTraversal(Node root) {
		// Checks if the tree is empty
		if(root == null) {
			return;
		}
		
		// Visit root
		System.out.print(root.data + " ");
		// Visit left subtree
		preorderTraversal(root.left);
		// Visit right subtree
		preorderTraversal(root.right);
	}
	
	/**
	 * Prints the inorder traversal of this tree
	 */
	public void inorderTraversal() {
		inorderTraversal(root);
	}
	
	private void inorderTraversal(Node root) {
		// Checks if the tree is empty
		if(root == null) {
			return;
		}
		
		// Visit left subtree
		inorderTraversal(root.left);
		// Visit root
		System.out.print(root.data + " ");
		// Visit right subtree
		inorderTraversal(root.right);
	}
	
	/**
	 * Prints the postorder traversal of this tree
	 */
	public void postorderTraversal() {
		postorderTraversal(root);
	}
	
	private void postorderTraversal(Node root) {
		// Checks if the tree is empty
		if(root == null) {
			return;
		}
		
		// Visit left subtree
		postorderTraversal(root.left);
		// Visit right subtree
		postorderTraversal(root.right);
		// Visit root
		System.out.print(root.data + " ");
		
	}
	
	public boolean isFull() {
		// Checks to see if the tree satisfies the relationship between height and the number of nodes
		return getNumberOfNodes() == Math.pow(2, getHeight()) - 1; 
	}
	
	
	public boolean contains(int value) {
		return contains(root, value);
	}
	
	private boolean contains(Node root, int value) {
		
		// Checks to see if the node is null
		if(root == null) {
			return false;
		}
		
		// Checks to see if the node contains the specified value
		if(root.data == value) {
			return true; // The value has been found
		}
		
		// Traverses the left and right subtree looking for one instance of the specified value
		return contains(root.left, value) || contains(root.right, value); 
	}
	
	/**
	* Return Integer.MAX_VALUE if a tree is empty
	*/
	public int getMin() {
		
		// Checks if the root is null
		if(root == null) {
			return Integer.MAX_VALUE; // Returns the default Integer.MAX_VALUE
		}
		
		return getMin(root, root.data); // Searches the binary tree for the smallest value
	}

	private int getMin(Node root, int currentMin) {
		
		// Checks to see if the root is null
		if(root == null) {
			return currentMin;
		} 
		
		// Compares the current minimum to the data of the current node
		currentMin = Math.min(root.data, currentMin);
		// Traverses the left and right subtree to see if there are any smaller values
		return Math.min(getMin(root.left, currentMin), getMin(root.right, currentMin));
		
	}
	
}
