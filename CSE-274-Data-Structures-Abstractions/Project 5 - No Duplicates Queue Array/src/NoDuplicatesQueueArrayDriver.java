
public class NoDuplicatesQueueArrayDriver {

	public static void main(String[] args) {
		
		System.out.println("Testing isEmpty()\n");
		
		NoDuplicatesQueueArray<Integer> nodupqueues = new NoDuplicatesQueueArray<Integer>();
		System.out.println("Initialized an empty no duplicates queue");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		
		System.out.println();
		
		System.out.println("Adding four integers to the queue: 1, 6, 3, 4");
		nodupqueues.enqueue(1);
		nodupqueues.enqueue(6);
		nodupqueues.enqueue(3);
		nodupqueues.enqueue(4);
		nodupqueues.enqueue(6);
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());

		System.out.println();
		
		System.out.println("testing getFront() and dequeue:");
		
		while(!nodupqueues.isEmpty()) {
			System.out.println(nodupqueues.getFront() + " is at the front");
			System.out.println(nodupqueues.dequeue() + " is removed from the front of the queue");
			System.out.println();
		}
		
		System.out.println("The queue should be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		
		System.out.println();
		System.out.println("Testing clear()");
		System.out.println();

		System.out.println("Adding one integer to the queue: 2");
		nodupqueues.enqueue(2);
		nodupqueues.enqueue(2);
		
		System.out.println("The queue shouldn't be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		
		System.out.println();
		
		System.out.println("Clearing the queue");
		nodupqueues.clear();
		
		System.out.println("The queue should be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		
		System.out.println();
		
		System.out.println("Adding 20 integers to the queue to force resizing:\nShould be 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20 ");
		for(int i = 1; i <= 20; i++) {
			nodupqueues.enqueue(i);
		}
		System.out.println("The queue shouldn't be empty: ");
		System.out.println("isEmpty() returns " + nodupqueues.isEmpty());
		System.out.println("getFront() should return 1");
		System.out.println(nodupqueues.getFront() + " is at the front");

		System.out.println();

		
		System.out.println("Clearing the queue");
		nodupqueues.clear();
		
		System.out.println();
		
		System.out.println("getFront() should throw an exception should be thrown since the queue is empty");
		nodupqueues.getFront();
	}
	
}
