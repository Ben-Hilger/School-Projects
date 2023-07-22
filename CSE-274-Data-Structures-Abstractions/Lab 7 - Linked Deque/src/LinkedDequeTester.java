import static org.junit.Assert.*;

import org.junit.Test;

public class LinkedDequeTester {

	@Test
	public void testLinkedDeque() {

		System.out.println("Testing Constructor\n"); // Informs the user that the constructor is being tested
		
		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // Ensures the deque starts empty, should return true
		System.out.println("isEmpty() returns true");
		
		System.out.println(); // Puts a space between other testing cases
	}

	@Test
	public void testClear() {

		System.out.println("Testing clear() method\n"); // Informs the user that the clear() method is being tested
		
		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear(); // Clears the deque
		System.out.println("Cleared the deque");
		
		assertTrue(myDeque.isEmpty()); // The deque should still be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToBack("Adam"); // Adds Adam to the back
		myDeque.addToBack("Ben"); // Adds Ben behind Adam
		myDeque.addToBack("Tom"); // Adds Tom behind Ben
		myDeque.addToBack("Elanor"); // Adds Elanor behind Tom
		System.out.println("Added to deque to contain the following:\nAdam Ben Tom Elanor");

		assertFalse(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear(); // Clears the deque
		System.out.println("Cleared the deque");
		
		assertTrue(myDeque.isEmpty()); // The deque should now be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases
		
	}

	@Test
	public void testAddToBack() {

		System.out.println("Testing addToBack() method\n"); // Informs the user that the addToBack() method is being tested
		
		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToBack("Ben"); // Adds "Ben" to the back of the deque
		System.out.println("Added \"Ben\" to the back of the deque");
		
		assertFalse(myDeque.isEmpty()); // The deque should now contain one item, and should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.getBack().equals("Ben")); // Since "Ben" was added to the back, getBack() should return Ben, so this should be true
		System.out.println("getBack() returns " + myDeque.getBack());
		assertTrue(myDeque.toString().equals("[Ben]")); // Since "Ben" is the only element, the toString() should return "[Ben]", so this should be true
		System.out.println("toString() returns " + myDeque.toString());
		
		System.out.println(); // Puts a space between other testing cases

		myDeque.clear(); // Clears the deque for futher testing
		System.out.println("Cleared the deque");
		
		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Adam"); // Adds Adam to the back
		myDeque.addToBack("Ben"); // Adds Ben behind Adam
		myDeque.addToBack("Tom"); // Adds Tom behind Ben
		myDeque.addToBack("Elanor"); // Adds Elanor behind Tom
		System.out.println("Added from the back deque to contain the following (in the specified order):\nAdam Ben Tom Elanor");

		System.out.println(); // Puts a space between other testing cases
		
		assertFalse(myDeque.isEmpty()); // The deque should now contain four items, and should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.getBack().equals("Elanor")); // Since "Elanor" is the most recent element added to the back, it should be returned by getBack()
		System.out.println("getBack() returns " + myDeque.getBack());
		assertTrue(myDeque.toString().equals("[Adam, Ben, Tom, Elanor]")); // Since is has four elements, the toString() should return "[Adam, Ben, Tom, Elanor]", so this should be true
		System.out.println("toString() returns " + myDeque.toString());
		
		System.out.println(); // Puts a space between other testing cases
	}

	@Test
	public void testAddToFront() {

		System.out.println("Testing addToFront() method\n"); // Informs the user that the addToBack() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToFront("Ben"); // Adds "Ben" to the front of the deque
		System.out.println("Added \"Ben\" to the front of the deque");
		
		assertFalse(myDeque.isEmpty()); // The deque should now contain one item, and should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.getFront().equals("Ben")); // Since "Ben" was added to the front, getFront() should return Ben, so this should be true
		System.out.println("getFront() returns " + myDeque.getFront());
		assertTrue(myDeque.toString().equals("[Ben]")); // Since "Ben" is the only element, the toString() should return "[Ben]", so this should be true
		System.out.println("toString() returns " + myDeque.toString());
		
		System.out.println(); // Puts a space between other testing cases

		myDeque.clear(); // Clears the deque for futher testing
		System.out.println("Cleared the deque");
		
		System.out.println(); // Puts a space between other testing cases

		myDeque.addToFront("Adam"); // Adds Adam to the front
		myDeque.addToFront("Ben"); // Adds Ben in front of Adam
		myDeque.addToFront("Tom"); // Adds Tom in front of Ben
		myDeque.addToFront("Elanor"); // Adds Elanor in front of Tom
		System.out.println("Added from the front the elements to the deque to contain the following (in the specified order):\nElanor Tom Ben Adam");

		System.out.println(); // Puts a space between other testing cases
		
		assertFalse(myDeque.isEmpty()); // The deque should now contain four items, and should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.getFront().equals("Elanor")); // Since "Elanor" is the most recent element added to the fronts, it should be returned by getFront()
		System.out.println("getFront() returns " + myDeque.getFront());
		assertTrue(myDeque.toString().equals("[Elanor, Tom, Ben, Adam]")); // Since is has four elements, the toString() should return "[Elanor, Tom, Ben, Ada]", so this should be true
		System.out.println("toString() returns " + myDeque.toString());
		
		System.out.println(); // Puts a space between other testing cases
		
	}

	@Test(expected = EmptyQueueException.class)
	public void testGetBack() {

		System.out.println("Testing getBack() method\n"); // Informs the user that the getBack() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToFront("Bob"); // Adds Bob to the front of the deque
		System.out.println("Added \"Bob\" to the front of the deque");
		
		System.out.println(); // Puts a space between other testing cases

		assertFalse(myDeque.isEmpty()); // The deque should no longer be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getBack().equals("Bob")); // Since "Bob" is the only element, getBack() should return Bob
		System.out.println("getBack() returns " + myDeque.getBack());
		
		myDeque.addToFront("Joe"); // Adds Joe to the front of the deque
		System.out.println("Added \"Joe\" to the front of the deque");
		
		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getBack().equals("Bob")); // Since "Bob" is the element in the back, getBack() should return Bob
		System.out.println("getBack() returns " + myDeque.getBack());
		
		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Daryn"); // Adds Daren to the back of the deque
		System.out.println("Added \"Daryn\" to the back of the deque");

		System.out.println(); // Puts a space between other testing cases

		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getBack().equals("Daryn")); // Since "Daryn" is the now the element in the back, getBack() should return Daryn
		System.out.println("getBack() returns " + myDeque.getBack());
				
		System.out.println(); // Puts a space between other testing cases

		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println(); // Puts a space between other testing cases
		
		System.out.println("An exception should be thrown since the stack is empty");
		System.out.println(); // Puts a space between other testing cases
		myDeque.getBack(); // An exception is expected to be thrown
	
	}

	@Test(expected = EmptyQueueException.class)
	public void testGetFront() {

		System.out.println("Testing getFront() method\n"); // Informs the user that the getFront() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToBack("Bob"); // Adds Bob to the back of the deque
		System.out.println("Added \"Bob\" to the back of the deque");
		
		System.out.println(); // Puts a space between other testing cases

		assertFalse(myDeque.isEmpty()); // The deque should no longer be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getFront().equals("Bob")); // Since "Bob" is the only element, getFront() should return Bob
		System.out.println("getFront() returns " + myDeque.getFront());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToBack("Joe"); // Adds Joe to the back of the deque
		System.out.println("Added \"Joe\" to the back of the deque");
		
		System.out.println(); // Puts a space between other testing cases

		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getFront().equals("Bob")); // Since "Bob" is the element in the front, getFront() should return Bob
		System.out.println("getFront() returns " + myDeque.getFront());
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToFront("Daryn"); // Adds Daren to the front of the deque
		System.out.println("Added \"Daryn\" to the front of the deque");
		
		System.out.println(); // Puts a space between other testing cases

		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty()); 
		assertTrue(myDeque.getFront().equals("Daryn")); // Since "Daryn" is the now the element in the front, getFront() should return Daryn
		System.out.println("getFront() returns " + myDeque.getFront());
				
		System.out.println(); // Puts a space between other testing cases

		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println(); // Puts a space between other testing cases
		
		System.out.println("An exception should be thrown since the stack is empty");
		System.out.println(); // Puts a space between other testing cases
		myDeque.getFront(); // An exception is expected to be thrown
		
	}

	@Test(expected = EmptyQueueException.class)
	public void testRemoveFront() {

		System.out.println("Testing removeFront() method\n"); // Informs the user that the removeFront() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToBack("Ben"); // Adds "Ben" to the back of the deque
		System.out.println("\"Ben\" has been added to the back of the queue");

		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		String front = myDeque.removeFront(); // Stores the string removed from the front of the deque
		assertTrue(front.equals("Ben")); // Since "Ben" is the only element in the deque, removeFront() should've removed "Ben", should be true 
		System.out.println("removeFront() removed and returned \"Ben\"");
		assertTrue(myDeque.isEmpty()); // The deque should be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.toString().equals("[]"));
		System.out.println("toString() returns []");
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println("Adding five elements to the front and back of the deque to get the following order:\nJoe Jim Bob Jared Kimberly");
		myDeque.addToFront("Bob"); // Adds Bob to the front of the deque
		myDeque.addToBack("Jared"); // Adds Jared to the back of the deque
		myDeque.addToBack("Kimberly"); // Adds Kimberly to the back of the deque
		myDeque.addToFront("Jim"); // Adds Jim to the front of the deque
		myDeque.addToFront("Joe"); // Adds Joe to the front of the deque

		assertTrue(myDeque.toString().equals("[Joe, Jim, Bob, Jared, Kimberly]")); // Since the elements were added in the above order, they should be ordered in the way specified, should return true
		System.out.println("toString() returns " + myDeque.toString());
		assertFalse(myDeque.isEmpty()); // Since there is five elements in the deque, it should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		for(int i = 0; i < 4; i++) {
			front = myDeque.removeFront();
			assertTrue(front.equals(
				i == 0 ? "Joe" : 
				i == 1 ? "Jim" :
				i == 2 ? "Bob" :
				i == 3 ? "Jared" : "")); // Depednign on how mant times it's gone through the loop, it should equal the corresponding element
			System.out.println("removeFront() removed and returned " + front);
			assertFalse(myDeque.isEmpty()); // Since there's always at least one element in the deque, it should never be empty, returns false
			System.out.println("isEmpty() returns " + myDeque.isEmpty());
			assertTrue(myDeque.toString().equals(
				i == 0 ? "[Jim, Bob, Jared, Kimberly]" :
				i == 1 ? "[Bob, Jared, Kimberly]" :
				i == 2 ? "[Jared, Kimberly]" :
				i == 3 ? "[Kimberly]" : "[]")); // Depending on how many times it's gone through the loop, it should equal the corresponding toString
			System.out.println("toString() returns " + myDeque.toString());
		}
		
		front = myDeque.removeFront(); // Stores the string removed from the front of the deque
		assertTrue(front.equals("Kimberly")); // Since "Ben" is the only element in the deque, removeFront() should've removed "Ben", should be true 
		System.out.println("removeFront() removed and returned \"Ben\"");
		assertTrue(myDeque.isEmpty()); // The deque should be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.toString().equals("[]"));
		System.out.println("toString() returns []");
		
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println("An exception should be thrown since the stack is empty");
		System.out.println(); // Puts a space between other testing cases
		myDeque.removeFront(); // An exception is expected to be thrown
		
	}

	@Test(expected = EmptyQueueException.class)
	public void testRemoveBack() {
		System.out.println("Testing removeBack() method\n"); // Informs the user that the removeFront() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases
		
		myDeque.addToFront("Ben"); // Adds "Ben" to the front of the deque
		System.out.println("\"Ben\" has been added to the front of the queue");

		assertFalse(myDeque.isEmpty()); // The deque shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		String back = myDeque.removeBack(); // Stores the string removed from the back of the deque
		assertTrue(back.equals("Ben")); // Since "Ben" is the only element in the deque, removeBack() should've removed "Ben", should be true 
		System.out.println("removeBack() removed and returned \"Ben\"");
		assertTrue(myDeque.isEmpty()); // The deque should be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.toString().equals("[]"));
		System.out.println("toString() returns []");
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println("Adding five elements to the front and back of the deque to get the following order:\nJoe Jim Bob Jared Kimberly");
		myDeque.addToFront("Bob"); // Adds Bob to the front of the deque
		myDeque.addToBack("Jared"); // Adds Jared to the back of the deque
		myDeque.addToBack("Kimberly"); // Adds Kimberly to the back of the deque
		myDeque.addToFront("Jim"); // Adds Jim to the front of the deque
		myDeque.addToFront("Joe"); // Adds Joe to the front of the deque

		assertTrue(myDeque.toString().equals("[Joe, Jim, Bob, Jared, Kimberly]")); // Since the elements were added in the above order, they should be ordered in the way specified, should return true
		System.out.println("toString() returns " + myDeque.toString());
		assertFalse(myDeque.isEmpty()); // Since there is five elements in the deque, it should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
		for(int i = 0; i < 4; i++) {
			back = myDeque.removeBack();
			assertTrue(back.equals(
				i == 0 ? "Kimberly" : 
				i == 1 ? "Jared" :
				i == 2 ? "Bob" :
				i == 3 ? "Jim" : "")); // Depednign on how mant times it's gone through the loop, it should equal the corresponding element
			System.out.println("removeBack() removed and returned " + back);
			assertFalse(myDeque.isEmpty()); // Since there's always at least one element in the deque, it should never be empty, returns false
			System.out.println("isEmpty() returns " + myDeque.isEmpty());
			assertTrue(myDeque.toString().equals(
				i == 0 ? "[Joe, Jim, Bob, Jared]" :
				i == 1 ? "[Joe, Jim, Bob]" :
				i == 2 ? "[Joe, Jim]" :
				i == 3 ? "[Joe]" : "[]")); // Depending on how many times it's gone through the loop, it should equal the corresponding toString
			System.out.println("toString() returns " + myDeque.toString());
		}
		
		back = myDeque.removeBack(); // Stores the string removed from the back of the deque
		assertTrue(back.equals("Joe")); // Since "Ben" is the only element in the deque, removeBack() should've removed "Ben", should be true 
		System.out.println("removeBack() removed and returned Joe");
		assertTrue(myDeque.isEmpty()); // The deque should be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		assertTrue(myDeque.toString().equals("[]"));
		System.out.println("toString() returns []");
		
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear();
		System.out.println("Cleared the deque");
		
		System.out.println("An exception should be thrown since the stack is empty");
		myDeque.removeBack(); // An exception is expected to be thrown
		
		System.out.println(); // Puts a space between other testing cases

	}

	@Test
	public void testIsEmpty() {

		System.out.println("Testing isEmpty() method\n"); // Informs the user that the removeFront() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.isEmpty()); // The deque should start empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Ben"); // Adds "Ben" to the back of the deque
		System.out.println("Added Ben to the back of the deque");
		
		assertFalse(myDeque.isEmpty()); // The deque now contains an element and shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Adam");
		myDeque.addToBack("Frankie");
		myDeque.addToBack("Ashlyn");
		myDeque.addToBack("Owen");
		System.out.println("Added four more elements to the deque to have the following order\nBen, Adam, Frankie, Ashlyn, Owen");
		
		assertFalse(myDeque.isEmpty()); // The deque now contains an element and shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());

		System.out.println(); // Puts a space between other testing cases

		myDeque.removeBack(); // Removes the element from the back
		myDeque.removeFront(); // Removes the element from the back
		System.out.println("Removed Owen from the back of the deque and Ben from the front of the deque");
		assertFalse(myDeque.isEmpty()); // The deque still contains three elements and shouldn't be empty, should return false
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
	
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear(); // Clears the deque
		System.out.println("Cleared the deque");
		
		assertTrue(myDeque.isEmpty()); // The deque should now be empty, should return true
		System.out.println("isEmpty() returns " + myDeque.isEmpty());
		
	}

	@Test
	public void testToString() {

		System.out.println("Testing toString() method\n"); // Informs the user that the removeFront() method is being tested

		LinkedDeque<String> myDeque = new LinkedDeque<>(); // Initialize a blank, empty deque
		System.out.println("Initialized a defualt deque with type String");

		assertTrue(myDeque.toString().equals("[]")); // The deque should start empty, so toString() should return []
		System.out.println("toString() returns " + myDeque.toString());
	
		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Ben"); // Adds "Ben" to the back of the deque
		System.out.println("Added Ben to the back of the deque");
		
		assertTrue(myDeque.toString().equals("[Ben]")); // Since "Ben" is the only element in the deque, toString should return "[Ben]"
		System.out.println("toString() returns " + myDeque.toString());

		System.out.println(); // Puts a space between other testing cases

		myDeque.addToBack("Adam"); // Adds Adam to the back
		myDeque.addToBack("Frankie"); // Adds Frankie to the back
		myDeque.addToFront("Ashlyn"); // Adds Ashlyn to the front
		myDeque.addToFront("Owen"); // Adds Owen to the front
		System.out.println("Added four more elements to the deque to have the following order\nOwen, Ashlyn, Ben, Adam, Frankie");
		
		assertTrue(myDeque.toString().equals("[Owen, Ashlyn, Ben, Adam, Frankie]")); // The deque now contains five elements and toString should return [Owen, Ashlyn, Ben, Adam, Frankie]
		System.out.println("toString() returns " + myDeque.toString());

		System.out.println(); // Puts a space between other testing cases

		myDeque.removeBack(); // Removes the element from the back
		myDeque.removeFront(); // Removes the element from the back
		System.out.println("Removed Owen from the front of the deque and Frankie from the back of the deque");
		assertTrue(myDeque.toString().equals("[Ashlyn, Ben, Adam]")); // The deque still contains three elements so toString should return "[Ashlyn, Ben, Adam]"
		System.out.println("toString() returns " + myDeque.toString());
	
		System.out.println(); // Puts a space between other testing cases
		
		myDeque.clear(); // Clears the deque
		System.out.println("Cleared the deque");
		
		assertTrue(myDeque.toString().equals("[]")); // The deque should now be empty, so toString should return the default "[]"
		System.out.println("toString() returns " + myDeque.toString());
		
		System.out.println(); // Puts a space between other testing cases
		
	}

}
