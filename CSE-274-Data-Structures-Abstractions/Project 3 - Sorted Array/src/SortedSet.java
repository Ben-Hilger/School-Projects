import java.util.Arrays;

/**
 * A circular doubly linked-node implementation of the Set ADT in which elements of the set
 * are always sorted (in this case, lexicographically, which is a fancy
 * way of saying "alphabetically").  Note that the String class has a compareTo
 * method which you should be using to assist you in keeping the set sorted.
 * 
 */
public class SortedSet implements SetInterface<String> {

	private Node head; // Stores the first node in the set
	private int size; // Stores the number of nodes in the set
		
	@Override
	public int getCurrentSize() {
		return size;
	}

	@Override
	public boolean isEmpty() {
		return size == 0; // Returns true if the number of nodes is 0, false otherwise
	}

	@Override
	public boolean add(String newEntry) {
	
		Node newNode = new Node(newEntry); // Stores the new node reference
		
		// Checks if the list is empty
		if(head == null) {
			
			newNode.prev = newNode; // Wraps the node around itself since it's an empty array
			newNode.next = newNode; // Wraps the node around itself since it's an empty array
			head = newNode; // Sets the new node as the head
		
		} else {
			
			Node current = head; // Stores current node being explored			
			boolean goneThrough = false; // Stores if it's searches through the entire list, indicating its at the back
			
			// Explores the set of nodes until it find one with a string that's further down in the alphabet
			while(!(current.data.compareTo(newNode.data) >= 0)) {

				current = current.next; // Sets current to the next node
				
				// Checks if its gone through the list
				if(current == head) {
					goneThrough = true; // Sets true to indicate it's aat the end 
					break; // Ends the while loop
				}
			}
			
			Node prev = current.prev; // Gets the prev node 
			
			// Puts the node in-between the current and prev node
			current.prev = newNode; // Sets the currents previous to the new node
			prev.next = newNode; // Sets next node of the prev to the new node
			newNode.prev = prev; // Sets the prev of the new node to the prev
			newNode.next = current; // Sets the next of the new node to the current
			
			// Checks to see if the new node should be the head node
			if(!goneThrough && current == head) {
				head = newNode;
			}
			
		}
				
		size++; // Increases the size to reflect adding a new node
		
		// As long as there's memory there should always be space to add
		return true;
	
	}

	@Override
	public boolean remove(String anEntry) {
		
		if(head == null) {
			return false;
		}
		
		// Checks if the size is one, and if it contains the desired string it clears the list
		if(size == 1 && head.data.equals(anEntry)) {
			clear();
			return true;
		}
		
		Node current = head; // Stores the current node being explored in the head
		boolean goneThrough = false; 
		
		// Explores the rest of the node list for the desired string entry
		while(current != head || !(current == head && goneThrough) ) {
			
			// Explores the data of the node to see if it contains the desired string
			if(current.data.equals(anEntry)) {
				
				Node prev = current.prev; // Gets the node before the node
				Node next = current.next;  // Gets the node after the node
				
				prev.next = next; // Sets the next of the prev to the next node, removing the reference to the current node
				next.prev = prev; // Sets the prev of the next node to the prev node, removing the reference to the current node
				current.next.prev = prev;
				
				if(current == head) {
					head = next;
				}
				
				size--; // Decreases the size by one to reflect the removal of a node
				
				return true;
			}

			
			current = current.next; 
		}
		
		
		return false;
	}

	@Override
	public String remove() {
		
		if(head == null) {
			return null;
		} else if(size == 1) { // Checks if the head is the only node, and if it is, it gets the data and then clears the set
			String data = head.data;
			clear();
			return data;
		}
		
		// Removes the head since it's most efficient
		Node prev = head.prev; // The node behind the head, the end of the node list
		Node next = head.next; // The node after the head, which will be the new head
		
		Node oldHead = head;
		
		// Checks to ensure there's another node to update
		if(next != null) {
			next.prev = prev; // Sets the prev of the next node to the prev of the old head 	
		}
		
		// Checks to ensure there's another node to update
		if(prev != null) {
			prev.next = next; // Sets the next of the new head to the prev node, completing the circular nature
		}
		
		head = next; // Sets the head to the new old, removing the reference to the old one
		
		size--; // Decreases the size by one to reflect the removal of a node
		
		return oldHead.data;
	}
	
	@Override
	public String removeLast() {
		
		// Checks if the node list is empty
		if(head == null) {
			return null;
		} else if(size == 1) { // Checks if size is equal to one, and if it is it clears the list and returns the heads data
			String data = head.data;
			clear();
			return data;
		}
		
		Node current = head; // Stores the current node being explored
		
		// Explores the node list to get to the last entry
		while(current.next != head) {
			current = current.next;
		}
		
		Node prev = current.prev;
		Node next = current.next;
				
		prev.next = next; // Sets the next of the new head to the prev node, completing the circular nature
		next.prev = prev; // Sets the prev of the next node to the prev of the old head 

		size--; // Decreases the size by one to reflect the removal of a node
		
		return current.data;
	}

	@Override
	public void clear() {
		head = null;
		size = 0;
	}

	@Override
	public boolean contains(String anEntry) {
		
		
		// Checks if the list is empty
		if(head == null) {
			return false;
		}
		
		// Checks the head to see if it has the desired string
		if(head.data.equals(anEntry)) {
			return true;
		}
		
		Node current = head.next; // Stores the current node being explored
		
		// Explores the rest of the node list to try and find the specified array
		while(current != head) {
			
			// Explores the data of the current node to see if it contains the specified data
			if(current.data.equals(anEntry)) {
				return true; // The specified data was found and it reports it to the user
			}
			
			current = current.next;
		}
		return false;
	}
	
	/*
	 * returns a string representation of the items in the set,
	 * specifically a space separated list of the strings, enclosed
	 * in square brackets [].  For example, if the set contained
	 * cat, dog, then this should return "[cat dog]".  If the
	 * set were empty, then this should return "[]".
	 */
	@Override
	public String toString() {
		
		String nodeString = "["; // Initial String
		
		// Checks to see if the list is empty
		if(head == null) {
			nodeString += "]";
			return nodeString;
		}
		
		nodeString += head.data; // Adds the head data to the nodeString
		Node current = head.next; // Stores the current node being explored
				
		// Explores the entire list adding all of the data to the string
		while(current != head) {
			nodeString += " " + current.data; // Adds the data of the node to the string, and adds a space if it isn;t in the front (isn't the head)
			current = current.next; // Sets current to the next node
		}
		
		nodeString += "]"; // Adds the closing bracket
		
		return nodeString;
	}
	
	@Override
	public String[] toArray() {
		String[] nodeArray = new String[size];
		
		int index = 0;
		
		// Checks if the list is empty
		if(head == null) {
			return nodeArray;
		} else {
			nodeArray[index] = head.data; // Adds the head data to the array
			index++; // Increases the index by one
		}
		
		Node current = head.next;
		// Explores the node list to populate the array with all of the values
		while(current != head) {
			nodeArray[index] = current.data; // Puts the data of the current node in the specified index in the array
			index++; // Increases the index by one for the next node data

			current = current.next; // Sets the current to the next node
		}
		
		return nodeArray;
	}


	private class Node {
		
		String data;  // Stores the data of the node
		Node next; // Stores the next node reference
		Node prev; // Stores the prev node reference
		
		/**
		 * Initalize a node with no data (empty string)
		 */
		public Node() {
			data = "";
			next = null;
			prev = null;
		}
		
		/**
		 * Initialize a node with the specified data
		 * @param d Thee data the node will contain
		 */
		public Node(String d) {
			data = d;
			next = null;
			prev = null;	
		}
		
		
	
	}

}


