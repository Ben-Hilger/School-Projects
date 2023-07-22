
public class NoDuplicatesPriorityLinkedNodesDriver {

	public static void main(String[] args) {
		
		
		System.out.println("Testing isEmpty() and getSize() throughout \n");
		
		NoDuplicatesPriorityLinkedNodes<Integer> nodupqueues = new NoDuplicatesPriorityLinkedNodes<Integer>();
		System.out.println("Initialized an empty no duplicates queue, should be empty and have size 0");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("getSize() returns " + nodupqueues.getSize());
		System.out.println("peek() should return null:");
		System.out.println("peek() returns " + nodupqueues.peek());
		
		System.out.println();
		
		System.out.println("Adding four integers to the queue: 1, 6, 3, 4 (will attempt to add a duplicate 6)\nShould be organized to: 6, 4, 3, 1\nShouldn't be empty and have a size 4");
		nodupqueues.add(1);
		nodupqueues.add(6);
		nodupqueues.add(3);
		nodupqueues.add(4);
		nodupqueues.add(6);
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("getSize() returns " + nodupqueues.getSize());
		
		
		System.out.println();
		
		System.out.println("Testing peek() and dequeue:");
		
		while(!nodupqueues.isEmpty()) {
			System.out.println(nodupqueues.peek() + " is at the front");
			System.out.println(nodupqueues.remove() + " is removed from the front of the queue");
			System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
			System.out.println("getSize() returns " + nodupqueues.getSize());
			System.out.println();
		}
		
		System.out.println("The queue should be empty and size should be zero: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("getSize() returns " + nodupqueues.getSize());
		System.out.println("peek() should return null:");
		System.out.println("peek() returns " + nodupqueues.peek());
		
		System.out.println();
		System.out.println("Testing clear()");
		System.out.println();

		System.out.println("Adding one integer to the queue: 2 (will attempt to add a duplicate 2)");
		nodupqueues.add(2);
		nodupqueues.add(2);
		
		System.out.println("The queue shouldn't be empty and size should be one: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("getSize() returns " + nodupqueues.getSize());

		System.out.println();
		
		System.out.println("Clearing the queue");
		nodupqueues.clear();
		
		System.out.println("The queue should be empty and size should be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		
		System.out.println();
		
		System.out.println("Adding 20 integers to the queue:\nShould be ordered to: 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1");
		for(int i = 1; i <= 20; i++) {
			nodupqueues.add(i);
		}
		System.out.println("The queue shouldn't be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("peek() should return 20");
		System.out.println(nodupqueues.peek() + " is at the front");

		System.out.println();
	}
	
}
