import static org.junit.Assert.*;

import org.junit.Test;

public class IntegerContainerTester {

	@Test
	public void testAdd() {
		// Creates a default instance of IntegerContainer
		IntegerContainer ic = new IntegerContainer();
		
		// The followings are the things we expect from an empty container
		assertEquals(ic.getCurrentSize(), 0);
		assertTrue(ic.isEmpty());
		assertFalse(ic.contains(9));
		
		// Let's add 10 items (the capacity)
		for(int i = 1; i <= IntegerContainer.DEFAULT_CAPACITY; i++) {
			assertTrue(ic.add(i));
			assertEquals(ic.getCurrentSize(), i);
			assertTrue(ic.contains(i));
		}
				
		// Let's try to add one more
		assertFalse(ic.add(99));
		assertEquals(ic.getCurrentSize(), 10);
		assertFalse(ic.contains(99));
		
	}

	@Test
	public void testRemove() {
		// Creates a default instance of IntegerContainer
		IntegerContainer ic = new IntegerContainer();
		
		// The followings are the things we expect from an empty container
		assertEquals(ic.getCurrentSize(), 0);
		assertTrue(ic.isEmpty());
		assertFalse(ic.contains(9));
		assertFalse(ic.remove(99));
		
		
		// Let's add 10 items (the capacity)
		for(int i = 1; i <= IntegerContainer.DEFAULT_CAPACITY; i++) {
			ic.add(i);
		}
		// Let's remove one item at a time
		for(int i = 1; i <= 10; i++) {
			assertTrue(ic.remove(i));
			assertEquals(ic.getCurrentSize(), 10-i);
			assertFalse(ic.contains(i));
		}
		
		
		
		
	}

}
