
public class NoDuplicatesPriorityLinkedNodes<T extends Comparable<? super T>> implements NoDuplicatesPriorityQueueInterface<T> {

	private Node headNode; // Stores the front node in the list
	
	@Override
	public void add(T newEntry) {

		Node newNode = new Node(newEntry);
		
		Node current = headNode; // Stores the current node being explored
		
		// Explores all of the data until a match is found
		while(current != null) {
			// Checks to see if the data is equal to the data specified
			if(current.data.equals(newEntry)) {
				return ; // Reports to the user the data was found
			}
			
			current = current.next; // Sets current to the next node in the list
		}
		
		// Checks to see if the queue is empty
		if(isEmpty()) {
			headNode = newNode; // Sets the new node as the head node, starting the list
		} else {
			
			
			if(newEntry.compareTo(headNode.data) >= 0) {
				newNode.next = headNode;
				headNode = newNode;
			} else { 
				current = headNode; // Stores the current node being explored

				// Explores the list until it finds a node with lower priority
				while(current != null && newEntry.compareTo(current.data) >= 0 && current.next != null && newEntry.compareTo(current.next.data) <= 0) {
					current = current.next; // Sets current to the next node in the list
				}
				
				newNode.next = current.next; // Sets the next of the new node to the next of the current node
				current.next = newNode; // Sets current next to the new node
				
				
			}
			
			
		}
	}

	@Override
	public T remove() {
		
		T front = headNode.data; // Temporarily stores that front data in the node
		headNode = headNode.next; // Sets the head node to the next node in the list, removing the reference of the front node
		
		return front; // Returns the data to the user
	}

	@Override
	public T peek() {
		 
		// Checks if the head node is empty
		if(isEmpty()) {
			return null; // Returns null to the user
		}
		
		return headNode.data; // Returns the data of the head node to the user, without changing the order
	}

	@Override
	public boolean isEmpty() {
		return headNode == null; // Returns true if the head node equals null
	}

	@Override
	public int getSize() {
		int count = 0; // Stores the number of nodes
		
		Node current = headNode; // Stores the current node being explored
		
		// Explores all of the data of the linked list
		while(current != null) {
			count++; // Increases the count
			current = current.next; // Sets current to the next node in the list
		}
		
		
		return count;
	}

	@Override
	public void clear() {
		headNode = null; // Sets the head node to null, clearing the list
	}

	private class Node {
		
		private T data;
		private Node next;
		
		public Node() {
			data = null;
			next = null;
		}
		
		public Node(T data) {
			this.data = data;
			next = null;
		}
		
	}
	
}


