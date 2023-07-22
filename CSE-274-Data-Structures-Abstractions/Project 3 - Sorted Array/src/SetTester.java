import static org.junit.Assert.*;

import java.util.Arrays;

import org.junit.Test;

public class SetTester {

	@Test
	public void testGetCurrentSize() {
		
		SortedSet set = new SortedSet();
		
		assertEquals(0, set.getCurrentSize()); // Expect: 0 and true. Returns : True
		
		// Adding four nodes the the set, expecting size to be: 4
		set.add("Example Text");
		set.add("Example Text");
		set.add("Example Text");
		set.add("Example Text");
		
		assertEquals(4, set.getCurrentSize()); // Expect: 4 and true. Returns : True
		
		// Removing two random nodes, expecting size to be: 2
		set.remove();
		set.remove();
		
		assertEquals(2, set.getCurrentSize()); // Expect: 2 and true. Returns : True
		
		// Clears the set
		set.clear();
		
		assertEquals(0, set.getCurrentSize()); // Expect: 0 and true. Returns : True
	
	}

	@Test
	public void testIsEmpty() {

		SortedSet set = new SortedSet();
		
		assertTrue(set.isEmpty()); // Expected: True, Returns: True
	
		// Adding three nodes to the set, expecting the sorted set to no longer be empty
		set.add("Example Text");
		set.add("Example Text");
		set.add("Example Text");
		
		assertFalse(set.isEmpty()); // Expecting: False, Returns: False
	
		// Removes two random nodes from the set
		assertFalse(set.isEmpty()); // Expecting: False, Returns: False
		set.remove();
		set.remove();
		
		// Clears the set
		set.clear();
		
		assertTrue(set.isEmpty()); // Expecting: True, Returns: True
	}

	@Test
	public void testAdd() {
		
		SortedSet set = new SortedSet();
		
		assertTrue(set.add("A")); // Adds "A" to the set, should return true and set should be "[A]"
		assertTrue(set.contains("A")); // Since "A" is in the set, it should find "A" and return true
		assertEquals(1, set.getCurrentSize()); // Since "A" is the only element in the set, the current size should be 1
		assertEquals("[A]", Arrays.toString(set.toArray())); // Since "A" is the only element, it should be: "[A]"
		
		assertTrue(set.add("A")); // Adds another "A" to the set, should return true and set should be "[A A]"
		assertTrue(set.contains("A")); // Since "A" is in the set, it should find "A" and return true
		assertEquals(2, set.getCurrentSize()); // Since there are two "A" elements in the set, the current size should be two
		assertEquals("[A A]", set.toString()); // Since there are two "A" elements in the set, it should be: "[A A]"
		
		assertTrue(set.add("C")); // Adds "C" to the sorted set, should return true and set should be "[A A C]"
		assertTrue(set.contains("C")); // Since "C" is in the set, it should find it and return true
		assertEquals(3, set.getCurrentSize()); // Since there are two "A" and one "C" the current size should be 3
		assertEquals("[A A C]", set.toString()); // Since there are two "A" elements and one "C" element in the set and it's sorted, it should be: "[A A C]"
		
		assertTrue(set.add("B"));  // Adds "B" to the sorted set, should return true and sorted set should be "[A A B C]"
		assertTrue(set.contains("B")); // Since "B" is in the set, it should find it and return true
		assertEquals(4, set.getCurrentSize()); // Since there are two "A", one "B" and one "C" the current size should be 4
		assertEquals("[A A B C]", set.toString()); // Since there are two "A" elements, one "B" element and one "C" element in the set and it's sorted, it should be: "[A A B C]"
		
		// Clears the set
		set.clear();
		
		assertTrue(set.add("B")); // Adds "B" to the sorted set, should return true and sorted set should be "[B]"
		assertTrue(set.contains("B"));  // Since "B" is in the set, it should find it and return true
		assertEquals(1, set.getCurrentSize()); // Since there is one "B" element the current size should be 1
		assertEquals("[B]", set.toString()); // Since there is one "B" element this should return "[B]"
		
		assertTrue(set.add("A")); // Adds "A" to the sorted set, should return true since the set is sorted it should be "[A B]"
		assertTrue(set.contains("A")); // Since "A" is in the set, it should find it and return true
		assertEquals(2, set.getCurrentSize()); // Since there is one "B" element and one "A" element the size should be 2
		assertEquals("[A B]", set.toString()); // Since there is one "B" element and one "A" element it should return "[A B]"
		
		assertTrue(set.add("C")); // Adds "C" to the sorted set, should return true since the set is sorted it should be "[A B C]"
		assertTrue(set.contains("C")); // Since "C" is in the set, it should find it and return true
		assertEquals(3, set.getCurrentSize()); // Since there is one "B" element, one "A" element and one "C" element the size should be 3
		assertEquals("[A B C]", set.toString()); // Since there is one "B" element, one "A" element and one "C" element it should be "[A B C]"
		
		assertTrue(set.add("B")); // Adds "B" to the sorted set, should return true and since the set is sorted it should be "[A B B C]"
		assertTrue(set.contains("B")); // Since "B" is in the set, it should find it and return true
		assertEquals(4, set.getCurrentSize()); // Since there is one "A" element, two "B" elements and one "C" element it should have a size of 4
		assertEquals("[A B B C]", set.toString()); // Since there is one "A" element, two "B" elements and one "C" element it should be: "[A B B C]"

		// Removes "A" from the set, the set should be "[B B C]"
		set.remove("A"); 
		assertEquals("[B B C]", set.toString());
		
		assertTrue(set.add("A")); // Adds "A" to the sorted set, should return true since the set is sorted it should be "[A B]"
		assertTrue(set.contains("A")); // Since "A" is in the set, it should find it and return true
		assertEquals(4, set.getCurrentSize()); // Since there is one "A" element, two "B" elements and one "C" element it should have a size of 4
		assertEquals("[A B B C]", set.toString()); // Since there is one "A" element, two "B" elements and one "C" element it should be: "[A B B C]"

	}

	@Test
	public void testRemoveString() {
		
		SortedSet set = new SortedSet();
		
		assertFalse(set.remove("A")); // Since there's nothing to remove in an empty set, it should return not be able to find "A" and return false 
		
		// Adds one item to the set
		set.add("H");
		
		assertTrue(set.remove("H")); // Since there's only one element "H" left, the remove should remove that element and return true.  The set should be: "[]" after
		assertFalse(set.contains("H")); // Since all of the elements of "H" have been removed from the set, the set should no longer contain "H"
		assertEquals(0, set.getCurrentSize()); // Since all of the elements have been removed, the set should have a size of zero
		assertEquals("[]", set.toString()); // Since the set is empty, it should return the default "[]" string
		assertTrue(set.isEmpty()); // Since there are no elements the set should be empty
		
		// Adds two of the same elements to the set, the set should be: "[H H]"
		set.add("H");
		set.add("H");
		
		assertEquals(2, set.getCurrentSize()); // Since two elements were added, the size of the set should return 2
		assertTrue(set.remove("H")); // Since it contains two "H" in the sorted array, it should return true. The set should be: "[H]" after
		assertTrue(set.contains("H")); // Since there were two elements of H in the array, the set should still contain another "H"
		assertFalse(set.isEmpty()); // Since only one element was removed, there should still be another element an the set shouldn't be empty
		assertEquals(1, set.getCurrentSize()); // Since one element was removed from a set of size 2, the new size should be 1
		assertEquals("[H]", set.toString()); // Since there is one "H" element, it should return "[H]"
	
		assertTrue(set.remove("H")); // Since there's only one element "H" left, the remove should remove that element and return true.  The set should be: "[]" after
		assertFalse(set.contains("H")); // Since all of the elements of "H" have been removed from the set, the set should no longer contain "H"
		assertEquals(0, set.getCurrentSize()); // Since all of the elements have been removed, the set should have a size of zero
		assertEquals("[]", set.toString()); // Since the set is empty, it should return the default "[]" string
		assertTrue(set.isEmpty()); // Since there are no elements the set should be empty
		
		// Adds four unique elements to the set, set should be: "[G H S W]"
		set.add("H");
		set.add("G");
		set.add("S");
		set.add("W");
		
		assertEquals(4, set.getCurrentSize()); // Since four elements were added, the size of the set should return four
		assertTrue(set.remove("G")); // Since "G" is in the sorted array, it should return true and remove "G". The set should be: "[H S W]" after
		assertFalse(set.contains("G")); // Since there was only one element of "G" in the array, the set should no longer contain it
		assertFalse(set.isEmpty()); // Since only one element was removed, there should still be more elements and the set shouldn't be empty
		assertEquals(3, set.getCurrentSize()); // Since one element was removed from a set of size 4, the new size should be 3
		assertEquals("[H S W]", set.toString()); // Since there are three elements still in the sorted set it should return: "[H S W]"
	
		assertTrue(set.remove("H")); // Since "H" is in the sorted set, it should return true and remove "H". The set should be: "[S W]" after
		assertFalse(set.contains("H")); // Since there was only one element of "H" in the array, the set should no longer contain it
		assertEquals(2, set.getCurrentSize()); // Since one element was removed from a set of size 3, the new size should be 2
		assertEquals("[S W]", set.toString()); // Since there are two elements still in the sorted set it should return: "[S W]"
			
		// Clears the set
		set.clear();
		
		// Adds three elements to the set, the set should be: "[H, S, W]"
		set.add("H");
		set.add("S");
		set.add("W");

		assertEquals(3, set.getCurrentSize()); // Since three elements were added, the size of the set should return three
		assertTrue(set.remove("W")); // Since "W" is in the sorted array, it should return true and remove "W". The set should be: "[H S]" after
		assertFalse(set.contains("W")); // Since there was only one element of "G" in the array, the set should no longer contain it
		assertFalse(set.isEmpty()); // Since only one element was removed, there should still be more elements and the set shouldn't be empty
		assertEquals(2, set.getCurrentSize()); // Since one element was removed from a set of size 4, the new size should be 3
		assertEquals("[H S]", set.toString()); // Since there are two elements still in the sorted set it should return: "[H S]"
	
		// Clears the set, set should be: "[]"
		set.clear();
		
		assertFalse(set.remove("S")); // Tries to remove "S" from an empty set, should return false

		
	}

	@Test
	public void testRemove() {
		
		SortedSet set = new SortedSet();
		
		assertEquals(null, set.remove()); // Since there's nothing to remove in an empty set, it should return null
		
		// Adds two of the same elements to the set, set should be: "[H H]"
		set.add("H");
		set.add("H");
		
		assertEquals(2, set.getCurrentSize()); // Since two elements were added, the size of the set should return 2
		assertEquals("H", set.remove()); // Since it contains two "H" in the sorted array, it should return one "H". The set should be: "[H]" after
		assertTrue(set.contains("H")); // Since there were two elements of H in the array, the set should still contain another "H"
		assertFalse(set.isEmpty()); // Since only one element was removed, there should still be another element an the set shouldn't be empty
		assertEquals(1, set.getCurrentSize()); // Since one element was removed from a set of size 2, the new size should be 1
		assertEquals("[H]", set.toString()); 
	
		assertEquals("H", set.remove()); // Since there's only one element "H" left, the remove should return that "H" element.  The set should be: "[]" after
		assertFalse(set.contains("H")); // Since all of the elements of "H" have been removed from the set, the set should no longer contain "H"
		assertEquals(0, set.getCurrentSize()); // Since all of the elements have been removed, the set should have a size of zero
		assertEquals("[]", set.toString()); // Since the set is empty, it should return the default "[]" string
		assertTrue(set.isEmpty()); // Since there are no elements the set should be empty
		
		// Adds four unique elements to the set, set should be: "[G H s W]"
		set.add("H");
		set.add("G");
		set.add("S");
		set.add("W");
		
		assertEquals(4, set.getCurrentSize()); // Since four elements were added, the size of the set should return four
		assertEquals("G", set.remove()); // Since "G" was in the front in the sorted array, it should return "G". The set should be: "[H S W]" after
		assertFalse(set.contains("G")); // Since there was only one element of "G" in the array, the set should no longer contain it
		assertFalse(set.isEmpty()); // Since only one element was removed, there should still be more elements and the set shouldn't be empty
		assertEquals(3, set.getCurrentSize()); // Since one element was removed from a set of size 4, the new size should be 3
		assertEquals("[H S W]", set.toString()); // Since there are three elements still in the sorted set it should return: "[H S W]"
	
		assertEquals("H", set.remove()); // Since "H" is in front of the sorted set, it should return "H". The set should be: "[S W]" after
		assertFalse(set.contains("H")); // Since there was only one element of "H" in the array, the set should no longer contain it
		assertEquals(2, set.getCurrentSize()); // Since one element was removed from a set of size 3, the new size should be 2
		assertEquals("[S W]", set.toString()); // Since there are two elements still in the sorted set it should return: "[S W]"
			
		// Clears the set
		set.clear();
		
		assertNull(set.remove()); // Tries to remove from an empty set, should return null
		
	}

	@Test
	public void testRemoveLast() {
		
		SortedSet set = new SortedSet();
		
		assertEquals(null, set.removeLast()); // Since the set is empty, there should be nothing to remove and return null
		
		// Adds one item to the set, set should be: "[R]"
		set.add("R");
		
		assertEquals("R", set.removeLast()); // Since there's only one element in the sorted set ("R"), it should return "R". The set will be clear after this call
		assertEquals(0, set.getCurrentSize()); // Since the only element was removed the size of the array should be zero
		
		// Adds two of the same items to the set, set should be: "[F F]"
		set.add("F");
		set.add("F");
		
		assertEquals(2, set.getCurrentSize()); // Since two elements were just added, the size of the array should be 2
		assertEquals("F", set.removeLast()); // Since the two elements in the sorted set are the same ("F"), it should return "F". The set will contain one "F" after this call
		assertEquals("F", set.removeLast()); // Since there's only one element in the sorted set ("F"), it should return "F". The set will be clear after this call
		assertEquals(0, set.getCurrentSize()); // Since the two elements were removed the size of the array should be zero
		
		// Adds two unique items to the set, set should be: "[F H]"
		set.add("F");
		set.add("H");
		
		assertEquals(2, set.getCurrentSize()); // Since two elements were just added, the size of the array should be 2
		assertEquals("H", set.removeLast()); // Since there are two elements in the sorted array ("F, H"), it should return "H" since H comes after F alphabetically. The set will contain one "F" after this call
		assertEquals("F", set.removeLast()); // Since there's only one element in the sorted set ("F"), it should return "F". The set will be clear after this call
		assertEquals(0, set.getCurrentSize()); // Since the two elements were removed the size of the array should be zero
		
		// Adds five unique items to the set set should be: "[A F H R Z]"
		set.add("F");
		set.add("H");
		set.add("R");
		set.add("A");
		set.add("Z");

		assertEquals(5, set.getCurrentSize()); // Since two elements were just added, the size of the array should be 2
		assertEquals("Z", set.removeLast()); // Since there are five elements in the sorted array ("A, F, H, R, Z"), it should return "Z" since Z comes last alphabetically. The set will contain ("A, F, H, R, Z") after
		assertEquals("R", set.removeLast()); // Since there are four elements in the sorted array ("A, F, H, R"), it should return "R" since R comes last alphabetically. The set will contain ("A, F, H") after
		assertEquals("H", set.removeLast()); // Since there are three elements in the sorted array ("A, F, H"), it should return "H" since H comes last alphabetically. The set will contain ("A, F") after
		assertEquals("F", set.removeLast()); // Since there are two elements in the sorted array ("A, F"), it should return "F" since F comes after A alphabetically. The set will contain ("A") after
		assertEquals("A", set.removeLast()); // Since there's only one element in the sorted set ("A"), it should return "A". The set will be clear after this call
		assertEquals(0, set.getCurrentSize()); // Since the two elements were removed the size of the array should be zero
		
		// Adds five unique items to the set and then removes "Z" and "R", set should be: "[A F H]"
		set.add("F");
		set.add("H");
		set.add("R");
		set.add("A");
		set.add("Z");
		set.remove("Z");
		set.remove("R");
				
		assertEquals(3, set.getCurrentSize()); // Since two elements were just added, the size of the array should be 2
		assertEquals("H", set.removeLast()); // Since there are three elements in the sorted array ("A, F, H"), it should return "H" since H comes last alphabetically. The set will contain ("A, F") after
		assertEquals("F", set.removeLast()); // Since there are two elements in the sorted array ("A, F"), it should return "F" since F comes after A alphabetically. The set will contain ("A") after
		assertEquals("A", set.removeLast()); // Since there's only one element in the sorted set ("A"), it should return "A". The set will be clear after this call
		assertEquals(0, set.getCurrentSize()); // Since the two elements were removed the size of the array should be zero
	}

	@Test
	public void testClear() {

		SortedSet set = new SortedSet();
		
		// Clearing an empty bag, expecting size == 0
		set.clear();
		assertEquals(0, set.getCurrentSize());
		assertTrue(set.isEmpty());
		assertEquals("[]", set.toString());
		
		// Adding five items to the set, expecting size to equal 5
		set.add("G");
		set.add("G");
		set.add("J");
		set.add("F");
		set.add("G");
		assertEquals(5, set.getCurrentSize());
		
		// Clearing the bag, expecting the size to equal zero 
		set.clear();
		assertEquals(0, set.getCurrentSize());
		assertTrue(set.isEmpty());
		assertEquals("[]", set.toString());
		
		// Adding two items to the set, expecting size to equal 2
		set.add("F");
		set.add("G");
		assertEquals(2, set.getCurrentSize());
		
		//Removing one item, expecting size to equal one
		set.remove();
		assertEquals(1, set.getCurrentSize());
		
		
		// Clearing the bag, expecting size to equal zero 
		set.clear();
		assertEquals(0, set.getCurrentSize());
		assertTrue(set.isEmpty());
		assertEquals("[]", set.toString());
		
		// Clearing the bag a second time, expecting size to equal zero 
		set.clear();
		assertEquals(0, set.getCurrentSize());
		assertTrue(set.isEmpty());
		assertEquals("[]", set.toString());
		
	}

	@Test
	public void testContains() {
		
		SortedSet set = new SortedSet();
	
		// Tries to find string "J" in the set, should return false since the set is empty
		assertFalse(set.contains("J"));
		
		// Adds string "J" to the set, set should be: "[J]"
		set.add("J");
		
		// Tries again to find string "J". It should find it since it has been added to the set
		assertTrue(set.contains("J"));
		
		// Adds 10 strings to the array, set should be: "[D E F F F F F H J J R ]"
		set.add("F");
		set.add("F");
		set.add("J");
		set.add("H");
		set.add("F");
		set.add("E");
		set.add("F");
		set.add("F");
		set.add("R");
		set.add("D");
	 	
		assertTrue(set.contains("F")); // Searches for the string "F", should return true since it has been added to the set
		assertFalse(set.contains("A")); // Tries to search for the string "A", should return false since it's not contained in the set
		assertTrue(set.contains("D")); // Searches for thhe strong "D", should return true since it's at the end of the set
		assertTrue(set.contains("E")); // Searches for the string "E", should return true since it's in the middle of the set
		
		// Removes the two occurrences of J, set should be: "[D E F F F F F H R ]"
		set.remove("J");
		set.remove("J");
	
		assertTrue(set.contains("F")); // Searches for the string "F", should return true since it has been added to the set
		assertFalse(set.contains("J")); // Tries to search for the string "J", should return false since it's no longer in the set
		assertTrue(set.contains("D")); // Searches for the string "D", should return true since it's at the end of the set
		assertTrue(set.contains("E")); // Searches for the string "E", should return true since it's in the middle of the set
		
		
	}

	@Test
	public void testToString() {

		SortedSet set = new SortedSet();
		
		// Since the set is empty, it should return the default: "[]" and should return true
		assertEquals("[]", set.toString());
		
		// Adds one item to the set
		set.add("E");
		assertEquals("[E]", set.toString()); // Since the set now has one sorted element, it should return: "[E]" and this assert should be true
		
		// Clears the set and adds two items to the set, set should be: "[E H]"
		set.clear();
		set.add("H");
		set.add("E");
		
		assertEquals("[E H]", set.toString()); // Since the set now has two sorted elements, it should return: "[E H]" and this assert should be true

		// Clears the set and then adds five items, set should be: "[E I J S Y]"
		set.clear();
		set.add("J");
		set.add("E");
		set.add("S");
		set.add("Y");
		set.add("I");
		
		assertEquals("[E I J S Y]", set.toString()); // Since the set has five sorted elements, it should return "[E I J S Y]" and this assert should be true
		
		// Removes two elements from the set, set should be: "[J S Y]"
		set.remove();
		set.remove();
	
		assertEquals("[J S Y]", set.toString()); // Since the set has three sorted elements, it should return "[J S Y]" and this assert should be true
		
		// Clears the set, set should be: "[]"
		set.clear();
		
		// Since the set is now cleared and empty, it should return the default: "[]" and should return true		
		assertEquals("[]", set.toString());
	}

	@Test
	public void testToArray() {
		
		SortedSet set = new SortedSet();
		
		// Tests to see if the empty set returns an empty array, the size of the array should be zero and return true
		assertEquals(0, set.toArray().length);
		
		// Adds one item to the set, set should be: "[F]"
		set.add("F");
		assertEquals(1, set.toArray().length); // The array should have a size of 2, and return true
		assertEquals("F", set.toArray()[0]); // The first element in the sorted array should be "E", and return true
		
		// Clears the set and adds two items to the set, set should be: "[E H]"
		set.clear();
		set.add("H");
		set.add("E");
		
		assertEquals(2, set.toArray().length); // The array should have a size of 2, and return true
		assertEquals("E", set.toArray()[0]); // The first element in the sorted array should be "E", and return true
		assertEquals("H", set.toArray()[1]); // The second element in the sorted array should be "H", and return true
		
		// Clears the set and then adds five items, set should be: "[E I J S Y]"
		set.clear();
		set.add("J");
		set.add("E");
		set.add("S");
		set.add("Y");
		set.add("I");
		
		assertEquals(5, set.toArray().length); // The array should have a size 5, and return true
		assertEquals("E", set.toArray()[0]); // The first element in the sorted array should be "E", and return true
		assertEquals("I", set.toArray()[1]); // The second element in the sorted array should be "H", and return true
		assertEquals("J", set.toArray()[2]); // The third element in the sorted array should be "E", and return true
		assertEquals("S", set.toArray()[3]); // The fourth element in the sorted array should be "H", and return true
		assertEquals("Y", set.toArray()[4]); // The fifth element in the sorted array should be "E", and return true
		
		// Removes two elements from the set, set should be: "[J S Y]"
		set.remove();
		set.remove();
	
		assertEquals(3, set.toArray().length); // The array should have a size 5, and return true
		assertEquals("J", set.toArray()[0]); // The first element in the sorted array should be "E", and return true
		assertEquals("S", set.toArray()[1]); // The second element in the sorted array should be "H", and return true
		assertEquals("Y", set.toArray()[2]); // The third element in the sorted array should be "E", and return true
		
		// Clears the set, set should be: "[]"
		set.clear();
		
		// Tests to see if the empty set returns an empty array, the size of the array should be zero and return true
		assertEquals(0, set.toArray().length);
				
	}

}
