import static org.junit.Assert.*;

import org.junit.Test;

public class TestArrayUtilityDriver {

	@Test
	public void testClear() {
		
		ArrayUtility bag = new ArrayUtility();
		
		bag.add(23);
		bag.add(56);
		assertEquals(bag.getCurrentSize(), 2);
		
		bag.clear();		
		
		assertEquals(bag.getCurrentSize(), 0);

	}

	@Test
	public void testGetCurrentSize() {
		
		ArrayUtility bag = new ArrayUtility();
		
		assertEquals(bag.getCurrentSize(), 0);
		
		bag.add(23);
		bag.add(56);
		bag.add(56);
		
		assertEquals(bag.getCurrentSize(), 3);
		
		bag.removeFirst();
		bag.removeFirst();

		assertEquals(bag.getCurrentSize(), 1);
		
	}
	

	@Test
	public void testIsEmpty() {
		
		ArrayUtility bag = new ArrayUtility(5);
		
		assertTrue(bag.isEmpty());
		
		bag.add(23);
		bag.add(21);
		
		assertFalse(bag.isEmpty());
		
		bag.add(23);
		bag.add(21);
		bag.add(45);
		
		assertFalse(bag.isEmpty());
		
		bag.removeFirst();
		bag.removeFirst();
		bag.removeFirst();
		bag.removeFirst();
		bag.removeFirst();
		
		assertTrue(bag.isEmpty());
		
	}
	
	@Test
	public void testContains() {
		
		ArrayUtility bag = new ArrayUtility();
		
		assertFalse(bag.contains(23));
		
		bag.add(23);
		bag.add(12);
	
		assertTrue(bag.contains(23));
		assertFalse(bag.contains(130));
		
		bag.remove(23);
	
		assertFalse(bag.contains(23));
		
	}

	@Test
	public void testGet() {
		
		ArrayUtility bag = new ArrayUtility();
		
		for(int i = 0; i < 10; i++) {
			bag.add(12);
		}
		
		assertEquals(bag.get(11), null);
		assertEquals(bag.get(-1), null);
		assertTrue(bag.get(9).equals(12));
		
		bag.removeLast();
		
		assertEquals(bag.get(9), null);
				
	}

	@Test
	public void testIndexOf() {
		
		ArrayUtility bag = new ArrayUtility();
		
		assertEquals(bag.indexOf(12), -1);
		
		bag.add(12);
		bag.add(12);
		
		assertEquals(bag.indexOf(12), 0);
		
		bag.add(13);
		assertEquals(bag.indexOf(13), 2);
	}

	@Test
	public void testGetFrequencyOf() {
		
		ArrayUtility bag = new ArrayUtility();
		
		assertEquals(bag.getFrequencyOf(12), 0);
		bag.add(12);
		bag.add(12);
		bag.add(13);
		bag.add(15);
		
		assertEquals(bag.getFrequencyOf(12), 2);
		assertEquals(bag.getFrequencyOf(13), 1);
		
	}

	@Test
	public void testAddInteger() {
	
		ArrayUtility bag = new ArrayUtility();
		
		for(int i = 0; i < 10; i++) {
			assertTrue(bag.add(9));
		}
		
		assertFalse(bag.add(9));
		bag.remove(9);
		
		assertTrue(bag.add(9));
		assertFalse(bag.add(14));

	}

	@Test
	public void testAddIntegerInt() {

		ArrayUtility bag = new ArrayUtility(5);
		
		assertFalse(bag.add(12, 1));
		assertTrue(bag.add(12, 0));
		assertTrue(bag.add(14, 1));
		assertFalse(bag.add(12, 3));
		
		bag.add(14);
		bag.add(14);
		bag.add(14);
		
		assertFalse(bag.add(16, 4));
		
		bag.removeFirst();
		
		assertTrue(bag.add(16, 2));

		assertFalse(bag.add(16, -1));
		
	}

	@Test
	public void testRemove() {
		
		ArrayUtility bag = new ArrayUtility(5);
		
		assertFalse(bag.remove(15));
		
		bag.add(15);
		
		assertTrue(bag.remove(15));
		assertFalse(bag.remove(15));
	
		bag.add(14);
		bag.add(14);
		bag.add(14);
		bag.add(14);
		bag.add(10);
		
		assertTrue(bag.remove(10));
		assertFalse(bag.remove(10));
		
		assertFalse(bag.remove(12));
		
		assertTrue(bag.remove(14));
		assertTrue(bag.remove(14));
		
	}

	@Test
	public void testRemoveFirst() {
	
		ArrayUtility bag = new ArrayUtility(5);
		
		assertFalse(bag.removeFirst());
		
		bag.add(15);
		bag.add(45);
		
		assertTrue(bag.removeFirst());
		assertTrue(bag.removeFirst());
		assertFalse(bag.removeFirst());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		assertTrue(bag.removeFirst());

	}
	

	@Test
	public void testRemoveLast() {

		ArrayUtility bag = new ArrayUtility(5);
		
		assertFalse(bag.removeLast());
		
		bag.add(15);
		bag.add(45);
		
		assertTrue(bag.removeLast());
		assertTrue(bag.removeLast());
		assertFalse(bag.removeLast());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		assertTrue(bag.removeLast());
	}

	@Test
	public void testRemoveMiddle() {
		
		ArrayUtility bag = new ArrayUtility(5);
		
		assertFalse(bag.removeMiddle());
		
		bag.add(15);
		bag.add(45);
		
		assertTrue(bag.removeMiddle());
		assertTrue(bag.removeMiddle());
		assertFalse(bag.removeMiddle());
		
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		bag.add(15);
		
		assertTrue(bag.removeMiddle());
		
	}

	@Test
	public void testReverse() {

		ArrayUtility bag = new ArrayUtility();
		Integer[] reversed;

		bag.add(15);
		reversed = new Integer[] { 15 };
		
		bag.reverse();
		
		for(int i = 0; i < bag.getCurrentSize(); i++) {
			assertTrue(bag.get(i).equals(reversed[i]));
		}
		
		bag.add(45);
		bag.add(56);
		reversed = new Integer[] {56, 45, 15};
		
		bag.reverse();
		
		for(int i = 0; i < bag.getCurrentSize(); i++) {
			assertTrue(bag.get(i).equals(reversed[i]));
		}
		
		bag.add(89);
		reversed = new Integer[] {89, 15, 45, 56};
		
		
		bag.reverse();
	
		for(int i = 0; i < bag.getCurrentSize(); i++) {
			assertTrue(bag.get(i).equals(reversed[i]));
		}
		
		bag.add(78);
		bag.add(69);
		bag.add(84);
		reversed = new Integer[] {84, 69, 78, 56, 45, 15, 89};

		bag.reverse();
		
		for(int i = 0; i < bag.getCurrentSize(); i++) {
			assertTrue(bag.get(i).equals(reversed[i]));
		}
	}

}
