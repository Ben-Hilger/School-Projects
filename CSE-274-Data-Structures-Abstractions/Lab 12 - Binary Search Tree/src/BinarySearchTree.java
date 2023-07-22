
public class BinarySearchTree {

	Node root;
	
	public BinarySearchTree() {
		root = null;
	}

	/*
	 * Adds the specified node to the BST
	 */
	public String add(String value) {
		
		// Checks if the binary search tree is empty
		if(root == null) {
			root = new Node(value); // Sets the root to a new node and stores the given value
			return value; // Returns the value to the use 
		}
		
		// Returns the result of the recursive call
		return add(root, value);
	}
	
	private String add(Node root, String value) {
		
		// Stores the result of the add method
		String result = null;
		
		// Compares the given value to the current root data
		int comparison = value.compareTo(root.data);
		
		// Checks if they are they same
		if(comparison == 0) {
			result = root.data; // Sets the result to the root data
			root.data = value; // Sets the data of the root to the given value, which is the same
		}
		
		// Determines if it's alphabetically less then or greater than the root data
		if(comparison < 0) {
			
			// Checks if the roots left subtree isn't empty
			if(root.left != null) {
				return add(root.left, value); 
			}
			
			// Sets the root's left child to a new node and stores the given value
			root.left = new Node(value);
			return value; // Returns the given value to the user
		}
		if(comparison > 0) {
			
			// Checks if the roots right subtree isn't empty
			if(root.right != null) {
				return add(root.right, value);
			}
			
			// Sets the root's right child to a new node and stores the given value
			root.right = new Node(value);
			return value; // Returns the given value to the user
		}

		return result; // Returns the result to the user
	}
	
	/*
	 * Returns true if the string is found in the BST
	 */
	public boolean contains(String value) {
		return contains(root, value);
	}
	
	private boolean contains(Node root, String value) {
		
		// Checks if the current root is null
		if(root == null)
			return false;
		
		// Compares the current value to the current root data
		int comparison = value.compareTo(root.data);
		
		// Checks if they are the same
		if(comparison == 0)
			return true; // Reports that it was found to the user
		if(comparison < 0)
			// Since it's alphabetically less than the current root data, it searches the left subtree for the given value
			return contains(root.left, value);
		

		// Since it's alphabetically greater than the current root data, it searches the right subtree for the given value
		return contains(root.right, value);
		
		
	}
	
	/*
	 * Checks whether the tree is empty or not
	 */
	public boolean isEmpty() {
		return root == null;
	}
	
	/*
	 * Removes the specified string from the BST
	 */
	public boolean remove(String s) {
	
		// Checks if there is an empty list
		if(root == null)
			return false;
		
		// Stores the root in a temporary variable
		Node parent = root;
		
		// Creates a temporary variable to store the node after the root
		Node current;
		
		// Compares the given value to the root data
		int comparison = s.compareTo(root.data);
		
		// Checks if it found it in the root
		if(comparison == 0) {
			// Special case
			
			// Checks if the root has two children
			if(root.left != null && root.right != null) {
				// Stores the node with the highest data in the left subtree
				Node max = root.left;
				
				// Traverses to the right-most node in the left subtree, which is the max node in a bst
				while(max.right != null) {
					max = max.right; // Sets max to the next rightmost node
				}
											
				// Removes the max node so it can take the place of the node
				boolean oper = remove(root, root.left, max.data);
			
				// Sets the root data to the max data
				root.data = max.data;
			
				// Returns the successfulness of the operation to the user
				return oper;
				
			} else if(root.left == null && root.right == null) {
				// Checks if it has no children
				root = null; // Sets it to an empty list
				
			} else if(root.left != null || root.right != null) {
				// Checks if it has one child
				root = root.left == null ? root.right : root.left; // Sets the root to its child, keeping it sorted
			}
			
			return true;
			
		} else if (comparison < 0) {
			// Checks if the given string is less alphabetically, which means the left subtree needs to be searched
			current = root.left;
		} else {
			// Checks if the given string is greater alphabetically, which means the right subtree needs to the searched
			current = root.right;
		}
		
		// Searches the determined subtree for the given string to remove
		return remove(parent, current, s);
	}
	
	/**
	 * Recursively searches the binary search tree for the given value to remove
	 * @param parent The parent of the current node in the binary search tree
	 * @param current The current node being explored
	 * @param value The string searching for
	 * @return true if the remove was successful, false otherwise
	 */
	private boolean remove(Node parent, Node current, String value) {
		
		// Checks if the current node is null, which means the string wasn't found
		if(current == null) {
			return false;
		}
		
		// Compares the given value to the current node data
		int comparison = value.compareTo(current.data);
		
		// Checks to see if it found the node in the current
		if(comparison == 0) {
			
			// Check to see if it's a leaf
			if(current.left == null && current.right == null) {
								
				// Determines if the current node is in the left or right subtree of the parent
				int comp = value.compareTo(parent.data);
				
				if(comp < 0) {
					// Since it's in the left subtree, it sets the parents left to null, removing the reference to the given node
					parent.left = null; 
					return true;
				} else {
					// Since it's in the right subtree, it sets the parents right to null, removing the reference to the given node
					parent.right = null;
					return true;
				}
			} else if(current.left != null && current.right != null) {
				// Checks if it has two children
				
				// Stores the max node from the left subtree
				Node max = current.left;
				
				// Goes to the rightmost node in the currents left subtree, which contains the max value
				while(max.right != null) {
					max = max.right;
				}
				
				// Removes the max node so it can replace the current node
				boolean oper = remove(current, current.left, max.data);
				
				// Sets the currents data to the data of the max node
				current.data = max.data;

				// Reports the success to the user
				return oper;
				
			} else if (current.right != null || current.left != null) {
				// Checks if it has a right child
				
				// Determines if the current node is to the left or right of the parent
				int comp = value.compareTo(parent.data);
				
				if(comp < 0) {
					// Since it's in the parents left subtree, it sets the parents left to currents child, removing current and keeping it sorted
					parent.left = current.right == null ? current.left : current.right;
				} else {
					// Since it's in the parents right subtree, it sets the parents right to currents child, removing current and keeping it sorted
					parent.right = current.right == null ? current.left : current.right;
				}
				
				return true;
	
			} 
			
		} else if(comparison < 0) {
			// Since the value is less than the current node, it searches deeper into the left subtree of the current
			return remove(current, current.left, value);
		} else {
			// Since the value is greater alphabetically than the current node, it searches deeper into the right subtree of the current
			return remove(current, current.right, value);
		}
		
		return false;
		
	}
	
	/**
	 * Prints the inorder traversal of this tree
	 */
	public void inorderTraversal() {
		inorderTraversal(root);
	}
	private void inorderTraversal(Node root) {
		if(root == null)
			return;
		inorderTraversal(root.left);
		System.out.print(root.data + " ");
		inorderTraversal(root.right);
	}
	
	private class Node{
		String data;
		Node left;
		Node right;
		
		public Node(String data) {
			this.data = data;
		}
	}
	
	/*
	 * Returns the height of the tree
	 */
	public int getHeight() {
		return getHeight(root);
	}
	
	private int getHeight(Node root) {
		if(root == null)
			return 0;
		return 1 + Math.max(getHeight(root.left), getHeight(root.right));
		
	}
	
	
	public static void main(String [] args) {
		BinarySearchTree bst = new BinarySearchTree();
		
		bst.add("D");
		bst.add("B");
		bst.add("F");
		bst.add("A");
		bst.add("C");
		bst.add("E");
		bst.add("G");
		
		System.out.println("The height: " + bst.getHeight());
		
		System.out.print("BST Inorder: ");
		bst.inorderTraversal();
		System.out.println();
		System.out.println(bst.contains("A"));
		System.out.println(bst.contains("B"));
		System.out.println(bst.contains("C"));
		System.out.println(bst.contains("D"));
		System.out.println(bst.contains("E"));
		System.out.println(bst.contains("F"));
		System.out.println(bst.contains("G"));

		System.out.println(bst.contains("X"));
		System.out.println(bst.contains("M"));
		System.out.println(bst.contains("L"));
		
	}
	
}
