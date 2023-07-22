import static org.junit.Assert.*;

import java.util.Arrays;

import org.junit.Test;

public class SetTester {

	@Test
	public void testGetSize() {
		
		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		
		Book foreverOne = new Book("The Forever One", "Owen S");
		Book shortOne = new Book("The Short One", "Mikala Johnson");
		Book ultimateGuide = new Book("The Ultimate Guide", "Omar S");
		
		// **** TESTING WITH AN EMPTY ARRAY SET ****
		
		// Expecting to see : 0
		assertEquals(arraySet.getSize(), 0);
		// Returns: 0

		// **** TESTING WITH TWO BOOKS ****
		
		// Adding Two Books ("The Forever One", "Owen S") ("The Short One", "Mikala Johnson")
		arraySet.add(foreverOne);
		arraySet.add(shortOne);
		
		// Expecting to see: 2
		assertEquals(arraySet.getSize(), 2);
		// Returns: 2
		
		// **** TESTING WITH 12 BOOKS ****
		
		// Adding 10 Books All: ("The Ultimate Guide", "Omar S")
		for(int i = 0; i < 10; i++) {
			arraySet.add(ultimateGuide);
		}
		
		// Expecting to see: 12
		assertEquals(arraySet.getSize(), 12);
		// Returns: 12
		
		// **** TESTING WITH FOUR BOOKS ****
		
		// Removing 8 Books
		for(int i = 0; i < 8; i++) {
			arraySet.remove();
		}
		
		// Expecting to see: 4
		assertEquals(arraySet.getSize(), 4);
		// Returns: 4
		
		// **** TESTING SECOND CONSTRUCTOR ****
		
		// Creating an empty set with special capacity 20
		arraySet = new ResizableArraySet(20);
		
		// **** TESTING WITH AN EMPTY ARRAY SET ****
		
		// Expecting to see : 0
		assertEquals(arraySet.getSize(), 0);
		// Returns: 0

		// **** TESTING WITH TWO BOOKS ****
		
		// Adding Two Books ("The Forever One", "Owen S") ("The Short One", "Mikala Johnson")
		arraySet.add(foreverOne);
		arraySet.add(shortOne);
		
		// Expecting to see: 2
		assertEquals(arraySet.getSize(), 2);
		// Returns: 2
		
		// **** TESTING WITH 12 BOOKS ****
		
		// Adding 10 Books All: ("The Ultimate Guide", "Omar S")
		for(int i = 0; i < 10; i++) {
			arraySet.add(ultimateGuide);
		}
		
		// Expecting to see: 12
		assertEquals(arraySet.getSize(), 12);
		// Returns: 12
		
		// **** TESTING WITH FOUR BOOKS AFTER REMOVING 8 ****
		
		// Removing 8 Books
		for(int i = 0; i < 8; i++) {
			arraySet.remove();
		}
		
		// Expecting to see: 4
		assertEquals(arraySet.getSize(), 4);
		// Returns: 4
		
	}

	@Test
	public void testIsEmpty() {

		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();

		Book assistance = new Book("The Assistance", "Nancy");
		
		// **** TESTING WITH AN EMPTY ARRAY SET ****
		
		// Expecting: True
		assertTrue(arraySet.isEmpty());
		// Returns: True 
		
		// **** TESTING WITH ONE BOOK ****
		
		// Adding one book ("The Assistance", "Nancy")
		arraySet.add(assistance);
		
		// Expecting: False
		assertFalse(arraySet.isEmpty());
		//Returns: False
		
		// **** TESTING AGAIN WITH AN EMPTY ARRAY SET ****
		
		// Removing the only book ("The Assistance", "Nancy")
		arraySet.remove();
		
		// Expecting: True
		assertTrue(arraySet.isEmpty());
		// Returns: True 
	
		// **** TESTING SECOND CONSTRUCTOR ****
		
		// Creating an empty set with special capacity 40
		arraySet = new ResizableArraySet(40);
				
		// **** TESTING WITH AN EMPTY ARRAY SET ****
		
		// Expecting: True
		assertTrue(arraySet.isEmpty());
		// Returns: True 
		
		// **** TESTING WITH ONE BOOK ****
		
		// Adding one book ("The Assistance", "Nancy")
		arraySet.add(assistance);
		
		// Expecting: False
		assertFalse(arraySet.isEmpty());
		//Returns: False
		
		// **** TESTING AGAIN WITH AN EMPTY ARRAY SET ****
		
		// Removing the only book ("The Assistance", "Nancy")
		arraySet.remove();
		
		// Expecting: True
		assertTrue(arraySet.isEmpty());
		// Returns: True
		
	}

	@Test
	public void testAdd() {
		
		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
			
		Book miamiWeekly = new Book("Miami Weekly", "MAP");
		Book matrices = new Book("Matrices", "Holland");
		Book campusRes = new Book("Campus Resources", "Dolland");
		
		// **** TESTING BY ADDING TWO BOOKS ****
		
		// Adding Two Books ("Matrices", "Holland") ("Campus Resources", "Dolland")
		// Expecting: True
		assertTrue(arraySet.add(matrices));
		assertTrue(arraySet.add(campusRes));
		// Returns: True
	
		// **** TESTING RESIZABILITY BY ADDING 20 BOOKS ****
		
		// Adding 20 Books ("Miami Weekly", "MAP")
		// Expecting: True
		for(int i = 0; i < 20; i++) {
			assertTrue(arraySet.add(miamiWeekly));
		}
		// Returns: True

		// Removing 10 books from the array
		for(int i = 0; i < 10; i++) {
			arraySet.remove();
		}
		
		// **** AGAIN TESTING RESIZABILITY BY ADDING 20 BOOKS AFTER REMOVING 10 ****
		
		// Adding 20 Books ("Miami Weekly", "MAP")
		// Expecting: True
		for(int i = 0; i < 20; i++) {
			assertTrue(arraySet.add(miamiWeekly));
		}
		// Returns: True
		
		// **** TESTING SECOND CONSTRUCTOR ****
		
		// Creating an empty set with special capacity 50
		arraySet = new ResizableArraySet(50);
			
		// **** TESTING BY ADDING TWO BOOKS *****
		
		// Adding Two Books ("Matricies", "Holland") ("Campus Resources", "Dolland")
		// Expecting: True
		assertTrue(arraySet.add(matrices));
		assertTrue(arraySet.add(campusRes));
		// Returns: True
	
		// **** TESTING RESIZABILITY BY ADDING 60 BOOKS ****
		
		// Adding 60 Books ("Miami Weekly", "MAP")
		// Expecting: True
		for(int i = 0; i < 60; i++) {
			assertTrue(arraySet.add(miamiWeekly));
		}
		// Returns: True

		// Removing 10 books from the array
		for(int i = 0; i < 10; i++) {
			arraySet.remove();
		}
		
		// **** AGAIN TESTING RESIZABILITY BY ADDING 20 BOOKS AFTER REMOVING 10 ****
		
		// Adding 20 Books ("Miami Weekly", "MAP")
		// Expecting: True
		for(int i = 0; i < 20; i++) {
			assertTrue(arraySet.add(miamiWeekly));
		}
		// Returns: True
		
	}

	@Test
	public void testRemoveBook() {
		
		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
			
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		Book pythonBasics = new Book("Python Basics", "Dr. Sam");
		Book capitalWeekly = new Book("Capital Weekly", "CAP");
		
		// **** TESTING REMOVING A BOOK FROM AN EMPTY ARRAY ****
		
		// Removing 1 book ("Python Basics", "Dr. Sam")
		// Expecting: False
		assertFalse(arraySet.remove(pythonBasics));
		// Returns: False
		
		// **** TESTING REMOVING A BOOK FROM AN ARRAY WITH TWO BOOKS ****
		
		// Adding 2 books, both ("Miami Weekly", "MAP")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
		
		// Removing 1 book (Miami Weekly", "Map"). Expecting array to be ("Miami Weekly", "Map") after
		// Expecting: True
		assertTrue(arraySet.remove(miamiWeekly));
		// Returns: True

		// **** TESTING REMOVING A BOOK THAT ISN'T IN ARRAY SET ****
		
		// Removing 1 book ("Capital Weekly", "CAP"), which isn't in array. Expecting array to be ("Miami Weekly", "Map") after
		// Expecting: False
		assertFalse(arraySet.remove(capitalWeekly));
		// Returns: False
		
		// Adding 20 books ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			arraySet.add(miamiWeekly);
		}
		
		// **** TESTING REMOVING ALL CONTENTS OF THE ARRAY SET OF AN AUTO-EXPANDED ARRAY SET ****
		
		// Removing all 21 books ("Miami Weekly", "Map")
		// Expecting: True
		for(int i = 0; i < 21; i++) {
			assertTrue(arraySet.remove(miamiWeekly));
		}
		// Returns: True
		
		// **** TESTING REMOVING AN EXTRA BOOK FROM THE ARRAY SET ****
		
		// Removing one too many books ("Miami Weekly", "Map")
		// Expecting: False
		assertFalse(arraySet.remove(miamiWeekly));
		// Returns: False
				
		
		// **** TESTING SECOND CONSTRUCTOR ****
		
		// Creating an empty set with special capacity 15
		arraySet = new ResizableArraySet(15);
			
		// **** TESTING REMOVING A BOOK FROM AN EMPTY ARRAY ****
		
		// Removing 1 book ("Python Basics", "Dr. Sam")
		// Expecting: False
		assertFalse(arraySet.remove(pythonBasics));
		// Returns: False
		
		// **** TESTING REMOVING A BOOK FROM AN ARRAY WITH TWO BOOKS ****
		
		// Adding 2 books ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
		
		// Removing 1 book (Miami Weekly", "Map"). Expecting array to be ("Miami Weekly", "Map") after
		// Expecting: True
		assertTrue(arraySet.remove(miamiWeekly));
		// Returns: True

		// **** TESTING REMOVING A BOOK THAT ISN'T IN ARRAY SET ****
		
		// Removing 1 book ("Capital Weekly", "CAP"), which isn't in array. Expecting array to be ("Miami Weekly", "Map") after
		// Expecting: False
		assertFalse(arraySet.remove(capitalWeekly));
		// Returns: False
		
		// Adding 20 books ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			arraySet.add(miamiWeekly);
		}
		
		// **** TESTING REMOVING ALL CONTENTS OF THE ARRAY SET OF AN AUTO-EXPANDED ARRAY SET ****
		
		// Removing all 21 books ("Miami Weekly", "Map")
		// Expecting: True
		for(int i = 0; i < 21; i++) {
			assertTrue(arraySet.remove(miamiWeekly));
		}
		// Returns: True
		
		// **** TESTING REMOVING AN EXTRA BOOK FROM THE ARRAY SET ****
		
		// Removing one too many books ("Miami Weekly", "Map")
		// Expecting: False
		assertFalse(arraySet.remove(miamiWeekly));
		// Returns: False
				
		
	}

	@Test
	public void testRemove() {
		
		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
				
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		
		// **** TESTING REMOVING A BOOK FROM AN EMPTY ARRAY SET ****
		
		// Removing 1 book 
		// Expecting: null
		assertEquals(arraySet.remove(), null);
		// Returns: null
		
		// **** TESTING REMOVING BOTH BOOKS FROM AN ARRAY SET CONTAINING TWO BOOKS ****
		
		// Adding 2 books ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
		
		// Removing 1 book. Expecting array to become: ("Miami Weekly", "Map")
		// Expecting: ("Miami Weekly", "Map")
		assertEquals(arraySet.remove(), miamiWeekly);
		// Returns: ("Miami Weekly", "Map")

		// Removing 1 book. Expecting array to be empty after
		// Expecting: ("Miami Weekly", "Map")
		assertEquals(arraySet.remove(), miamiWeekly);
		// Returns: ("Miami Weekly", "Map")
		
		// **** TESTING REMOVING ALL BOOKS FROM AN ARRAY SET THATS BEEN EXPANDED ****
		
		// Adding 20 books ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			arraySet.add(miamiWeekly);
		}
		
		// Removing all 20 books ("Miami Weekly", "Map")
		// Expecting each case: ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			assertEquals(arraySet.remove(), miamiWeekly);
		}
		// Returns: ("Miami Weekly", "Map") each case
		
		// **** TESTING REMOVING A BOOK FROM AN ARRAY SET THATS BEEN EXPANDED AND THEN EMPTYED ****
		
		// Removing one too many books ("Miami Weekly", "Map")
		// Expecting: False
		assertEquals(arraySet.remove(), null);
		// Returns: False
		
		// **** TESTING SECOND ARRAY
		
		// Creating an empty set with special capacity 15
		arraySet = new ResizableArraySet(15);
						
		// **** TESTING REMOVING A BOOK FROM AN EMPTY ARRAY SET ****
		
		// Removing 1 book 
		// Expecting: null
		assertEquals(arraySet.remove(), null);
		// Returns: null
		
		// **** TESTING REMOVING BOTH BOOKS FROM AN ARRAY SET CONTAINING TWO BOOKS ****
		
		// Adding 2 books ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
		
		// Removing 1 book. Expecting array to become: ("Miami Weekly", "Map")
		// Expecting: ("Miami Weekly", "Map")
		assertEquals(arraySet.remove(), miamiWeekly);
		// Returns: ("Miami Weekly", "Map")

		// Removing 1 book. Expecting array to be empty after
		// Expecting: ("Miami Weekly", "Map")
		assertEquals(arraySet.remove(), miamiWeekly);
		// Returns: ("Miami Weekly", "Map")
		
		// **** TESTING REMOVING ALL BOOKS FROM AN ARRAY SET THATS BEEN EXPANDED ****
		
		// Adding 20 books ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			arraySet.add(miamiWeekly);
		}
		
		// Removing all 20 books ("Miami Weekly", "Map")
		// Expecting each case: ("Miami Weekly", "Map")
		for(int i = 0; i < 20; i++) {
			assertEquals(arraySet.remove(), miamiWeekly);
		}
		// Returns: ("Miami Weekly", "Map") each case
		
		// **** TESTING REMOVING A BOOK FROM AN ARRAY SET THATS BEEN EXPANDED AND THEN EMPTYED ****
		
		// Removing one too many books ("Miami Weekly", "Map")
		// Expecting: False
		assertEquals(arraySet.remove(), null);
		// Returns: False
				

	}

	@Test
	public void testClear() {

		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
	
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		
		// **** TESTING OF AN ARRAY CLEARED WHEN IT CONTAINED NO CONTENTS ****		
		
		// Creating an array and filling it with the same two books for comparing ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		Book[] compareArray = new Book[] {};
	
		// Clears the arraySet and the compare array
		arraySet.clear();
		compareArray = new Book[0];
		// Expected: True
		assertArrayEquals(arraySet.toArray(), compareArray);
		// Expected: True
		
		// **** TESTING OF AN ARRAY CLEARED WHEN CONTAINED CONTENTS ****
		
		// Adding 2 books ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
	
		// Clears the arraySet and the compare array
		arraySet.clear();
		compareArray = new Book[0];
		// Expected: True
		assertArrayEquals(arraySet.toArray(), compareArray);
		// Expected: True
		
		// **** TESTING SECOND ARRAY ****
	
		// Creating an empty set with special capacity 15
		arraySet = new ResizableArraySet(15);
			
		// **** TESTING OF AN ARRAY CLEARED WHEN IT CONTAINED NO CONTENTS ****		
			
		// Clears the arraySet and the compare array
		arraySet.clear();
		compareArray = new Book[0];
		// Expected: True
		assertArrayEquals(arraySet.toArray(), compareArray);
		// Expected: True
		
		// **** TESTING OF AN ARRAY CLEARED WHEN CONTAINED CONTENTS ****
		
		// Adding 2 books ("Miami Weekly", "MAP") ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		arraySet.add(miamiWeekly);
	
		// Clears the arraySet and the compare array
		arraySet.clear();
		compareArray = new Book[0];
		// Expected: True
		assertArrayEquals(arraySet.toArray(), compareArray);
		// Expected: True
		
	}

	@Test
	public void testContains() {
		
		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		
		Book mimaiWeekly = new Book("Miami Weekly", "Map");
		
		// **** SEARCHES FOR A BOOK IN AN EMPTY ARRAY SET ****
		
		// Searches for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: False
		assertFalse(arraySet.contains(mimaiWeekly));
		// Returns: False
		
		// **** SEARCHES FOR A BOOK CONTAINED IN ARRAY TWICE ****
		
		// Adds 2 books ("Miami Weekly", "Map") ("Miami Weekly", "Map")
		arraySet.add(mimaiWeekly);
		arraySet.add(mimaiWeekly);
		
		// Searches again for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: True
		assertTrue(arraySet.contains(mimaiWeekly));
		// Returns: True
				
		// **** SEARCHES FOR A BOOK NOT CONTAINED IN A POPULATED ARRAY SET ****
		
		// Searches for a book not contained in the arraySet ("Comis Speakers", "Com")
		// Expected: False
		assertFalse(arraySet.contains(new Book("Comis Speakers", "Com")));
		
		// **** TESTS SEARCHING IN A CLEARED ARRAY **** 
		
		// Clears the arraySet
		arraySet.clear();
		
		// Searches again for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: False
		assertFalse(arraySet.contains(mimaiWeekly));
		// Returns: False
				
		// **** TESTING OF SECOND ARRAY ****
	
		// Creating an empty set with special capacity 15
		arraySet = new ResizableArraySet(15);

		// **** SEARCHES FOR A BOOK IN AN EMPTY ARRAY SET ****
		
		// Searches for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: False
		assertFalse(arraySet.contains(mimaiWeekly));
		// Returns: False
		
		// **** SEARCHES FOR A BOOK CONTAINED IN ARRAY TWICE ****
		
		// Adds 2 books ("Miami Weekly", "Map") ("Miami Weekly", "Map")
		arraySet.add(mimaiWeekly);
		arraySet.add(mimaiWeekly);
		
		// Searches again for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: True
		assertTrue(arraySet.contains(mimaiWeekly));
		// Returns: True
				
		// **** SEARCHES FOR A BOOK NOT CONTAINED IN A POPULATED ARRAY SET ****
		
		// Searches for a book not contained in the arraySet ("Comis Speakers", "Com")
		// Expected: False
		assertFalse(arraySet.contains(new Book("Comis Speakers", "Com")));
		
		// **** TESTS SEARCHING IN A CLEARED ARRAY **** 
		
		// Clears the arraySet
		arraySet.clear();
		
		// Searches again for the book ("Miami Weekly", "Map") in the arraySet
		// Expected: False
		assertFalse(arraySet.contains(mimaiWeekly));
		// Returns: False
				
	}

	@Test
	public void testUnion() {

		// Creating two empty sets with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		ResizableArraySet arraySet2 = new ResizableArraySet();
				
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		Book codeInterview = new Book("Cracking the Coding Interview 101", "James Crawford");
		Book uniformWashing = new Book("Properly Washing a Uniform", "Dr. Bonson");
		
		// **** TESTING BOTH EMPTY ****
	
		// Creates an array to compare to the union with the expected outcome values, expecting: [] - empty
		Book[] expectingArray = new Book[0];
		
		// Gets the union set between the two arraySets
		SetInterface unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: [] - empty
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected union results: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, uniformWashing};
		
		// Gets the union set between the two arraySets
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected union results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, codeInterview, uniformWashing};
		
		// Gets the union set between the two arraySets
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		//  **** TESTING BOTH HAVING BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected union set: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
		expectingArray = new Book[] {miamiWeekly, uniformWashing, codeInterview};
		
		// Getting the union between the two arraySets, expecting: ("Miami Weekly", "Map")  ("Properly Washing a Uniform", "Dr. Bonson")("Cracking the Coding Interview 101", "James Crawford") 
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal:  ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns that it equals to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
	
	
		// Creating two empty sets with special capacity 20 and 15
		arraySet = new ResizableArraySet(20);
		arraySet2 = new ResizableArraySet(15);
	
		
		// **** TESTING BOTH EMPTY ****
	
		// Resets the comparing array to compare to the union with the expected outcome values, expecting: [] - empty
		expectingArray = new Book[0];
		
		// Gets the union set between the two arraySets
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: [] - empty
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected union results: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, uniformWashing};
		
		// Gets the union set between the two arraySets
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected union results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, codeInterview, uniformWashing};
		
		// Gets the union set between the two arraySets
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns: unionSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		//  **** TESTING BOTH HAVING BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected union set: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
		expectingArray = new Book[] {miamiWeekly, uniformWashing, codeInterview};
		
		// Getting the union between the two arraySets, expecting: ("Miami Weekly", "Map")  ("Properly Washing a Uniform", "Dr. Bonson")("Cracking the Coding Interview 101", "James Crawford") 
		unionSet = arraySet.union(arraySet2);
		// Expecting unionSet to equal:  ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
		assertArrayEquals(unionSet.toArray(), expectingArray);
		// Returns that it equals to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford")
	
	
	}

	@Test
	public void testIntersection() {

		// Creating two empty sets with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		ResizableArraySet arraySet2 = new ResizableArraySet();
				
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		Book codeInterview = new Book("Cracking the Coding Interview 101", "James Crawford");
		Book uniformWashing = new Book("Properly Washing a Uniform", "Dr. Bonson");
		
		// **** TESTING BOTH EMPTY ****
	
		// Creates an array to compare to the intersection with the expected outcome values, expecting: [] - empty
		Book[] expectingArray = new Book[0];
		
		// Gets the intersection between the two arraySets
		SetInterface interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting intersection to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		//  **** TESTING BOTH HAVING SIMILAR BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected intersection set: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, uniformWashing};
		
		// Getting the intersection between the two arraySets, expecting: ("Miami Weekly", "Map")  ("Properly Washing a Uniform", "Dr. Bonson")
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal:  ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns that interSet equals: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
	
		// **** TESTING BOTH HAVING UNIQUE BOOKS ****
		
		// Clearing both arraySets
		arraySet.clear();
		arraySet2.clear();
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
	
		//Adding one book ("Cracking the Coding Interview 101", "James Crawford") to arraySet2
		arraySet2.add(codeInterview);
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		
		
		// Creating two empty sets with special capacity 15 and 20
		arraySet = new ResizableArraySet(15);
		arraySet2 = new ResizableArraySet(20);
				
		// **** TESTING BOTH EMPTY ****
	
		// Creates an array to compare to the intersection with the expected outcome values, expecting: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting intersection to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		//  **** TESTING BOTH HAVING SIMILAR BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected intersection set: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] {miamiWeekly, uniformWashing};
		
		// Getting the intersection between the two arraySets, expecting: ("Miami Weekly", "Map")  ("Properly Washing a Uniform", "Dr. Bonson")
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal:  ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns that interSet equals: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
	
		// **** TESTING BOTH HAVING UNIQUE BOOKS ****
		
		// Clearing both arraySets
		arraySet.clear();
		arraySet2.clear();
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
	
		//Adding one book ("Cracking the Coding Interview 101", "James Crawford") to arraySet2
		arraySet2.add(codeInterview);
		
		// Resets the comparing array to compare with the expected intersection results: [] - empty
		expectingArray = new Book[0];
		
		// Gets the intersection set between the two arraySets
		interSet = arraySet.intersection(arraySet2);
		// Expecting interSet to equal: [] - empty
		assertArrayEquals(interSet.toArray(), expectingArray);
		// Returns: interSet is equal to: [] - empty
		
		
	
	}

	@Test
	public void testDifference() {

		// Creating two empty sets with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		ResizableArraySet arraySet2 = new ResizableArraySet();
				
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		Book codeInterview = new Book("Cracking the Coding Interview 101", "James Crawford");
		Book uniformWashing = new Book("Properly Washing a Uniform", "Dr. Bonson");
		
		// **** TESTING BOTH EMPTY ****
	
		// Creates an array to compare to the difference with the expected outcome values, expecting: [] - empty
		Book[] expectingArray = new Book[0];
		
		// Gets the difference between the two arraySets
		SetInterface diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: [] - empty
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected difference results: [] - empty
		expectingArray = new Book[] { miamiWeekly, uniformWashing };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting difference to equal: [] - empty
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: [] - empty
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected difference results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, codeInterview, uniformWashing };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		//  **** TESTING BOTH HAVING SIMILAR BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected difference set: ("Cracking the Coding Interview 101", "James Crawford")
		expectingArray = new Book[] { codeInterview };
		
		// Getting the difference between the two arraySets, expecting: ("Cracking the Coding Interview 101", "James Crawford")
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal:  ("Cracking the Coding Interview 101", "James Crawford")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns that diffSet equals: ("Cracking the Coding Interview 101", "James Crawford")
	
		// **** TESTING BOTH HAVING UNIQUE BOOKS ****
		
		// Clearing both arraySets
		arraySet.clear();
		arraySet2.clear();
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
	
		//Adding one book ("Cracking the Coding Interview 101", "James Crawford") to arraySet2
		arraySet2.add(codeInterview);
		
		// Resets the comparing array to compare with the expected difference results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, uniformWashing, codeInterview };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
	
		
		// Creating two empty sets with special capacity 15 and 20
		arraySet = new ResizableArraySet(15);
		arraySet2 = new ResizableArraySet(20);

		// **** TESTING BOTH EMPTY ****
	
		// Creates an array to compare to the difference with the expected outcome values, expecting: [] - empty
		expectingArray = new Book[0];
		
		// Gets the difference between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: [] - empty
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: [] - empty
		
		// **** TESTING ONLY SECOND BEING EMPTY
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		// Leaving the second arraySet empty
		
		// Resets the comparing array to compare with the expected difference results: [] - empty
		expectingArray = new Book[] { miamiWeekly, uniformWashing };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting difference to equal: [] - empty
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: [] - empty
				
		// Clears the first arraySet
		arraySet.clear();
		
		// **** TESTING ONLY FIRST BEING EMPTY ****
		
		// Adding three books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson") to arraySet2
		arraySet2.add(miamiWeekly);
		arraySet2.add(codeInterview);
		arraySet2.add(uniformWashing);
		// Leaving the first Array empty
		
		// Resets the comparing array to compare with the expected difference results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, codeInterview, uniformWashing };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		//  **** TESTING BOTH HAVING SIMILAR BOOKS ****
		
		// Adds the original two books back into arraySet: ("Miami Weekly", "Map") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
		
		// Resets comparing array to the expected difference set: ("Cracking the Coding Interview 101", "James Crawford")
		expectingArray = new Book[] { codeInterview };
		
		// Getting the difference between the two arraySets, expecting: ("Cracking the Coding Interview 101", "James Crawford")
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal:  ("Cracking the Coding Interview 101", "James Crawford")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns that diffSet equals: ("Cracking the Coding Interview 101", "James Crawford")
	
		// **** TESTING BOTH HAVING UNIQUE BOOKS ****
		
		// Clearing both arraySets
		arraySet.clear();
		arraySet2.clear();
		
		// Adding two books ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") to arraySet
		arraySet.add(miamiWeekly);
		arraySet.add(uniformWashing);
	
		//Adding one book ("Cracking the Coding Interview 101", "James Crawford") to arraySet2
		arraySet2.add(codeInterview);
		
		// Resets the comparing array to compare with the expected difference results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, uniformWashing, codeInterview };
		
		// Gets the difference set between the two arraySets
		diffSet = arraySet.difference(arraySet2);
		// Expecting diffSet to equal: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(diffSet.toArray(), expectingArray);
		// Returns: diffSet is equal to: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
	}

	@Test
	public void testToArray() {

		// Creating an empty set with default capacity
		ResizableArraySet arraySet = new ResizableArraySet();
		
		Book miamiWeekly = new Book("Miami Weekly", "Map");
		Book codeInterview = new Book("Cracking the Coding Interview 101", "James Crawford");
		Book uniformWashing = new Book("Properly Washing a Uniform", "Dr. Bonson");
		
		// **** TESTING WITH AN EMPTY ARRAYSET ****
		
		// Creating a comparing array with the expected toArray results: [] - empty
		Book[] expectingArray = new Book[0];
		
		// Expecting toArray to equals: [] - empty
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: [] - empty
		
		// **** TESTING WITH ONE BOOK ****
		
		// Adding one book to arraySet: ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		
		// Updating the comparing array with the new expected toArray results: ("Miami Weekly", "Map")
		expectingArray = new Book[] { miamiWeekly };
		
		// Expecting toArray to equals: ("Miami Weekly", "Map")
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Miami Weekly", "Map")
		
		// **** TESTING WITH THREE BOOKS ****
		
		// Adding two books to arraySet: ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(codeInterview);
		arraySet.add(uniformWashing);
		
		// Updating the comparing array with the new expected toArray results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, codeInterview, uniformWashing };
		
		// Expecting toArray to equals: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		// **** TESTING WITH TWO BOOKS ****
		
		// Removing one book from the arraySet: ("Miami Weekly", "Map")
		arraySet.remove(miamiWeekly);
		
		// Updating the comparing array with the new expected toArray results: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		expectingArray = new Book[] { uniformWashing,codeInterview };
		
		// Expecting toArray to equals: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		
	
		// Creating an empty set with speical capacity 15
		arraySet = new ResizableArraySet();
	
		// **** TESTING WITH AN EMPTY ARRAYSET ****
		
		// Creating a comparing array with the expected toArray results: [] - empty
		expectingArray = new Book[0];
		
		// Expecting toArray to equals: [] - empty
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: [] - empty
		
		// **** TESTING WITH ONE BOOK ****
		
		// Adding one book to arraySet: ("Miami Weekly", "Map")
		arraySet.add(miamiWeekly);
		
		// Updating the comparing array with the new expected toArray results: ("Miami Weekly", "Map")
		expectingArray = new Book[] { miamiWeekly };
		
		// Expecting toArray to equals: ("Miami Weekly", "Map")
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Miami Weekly", "Map")
		
		// **** TESTING WITH THREE BOOKS ****
		
		// Adding two books to arraySet: ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		arraySet.add(codeInterview);
		arraySet.add(uniformWashing);
		
		// Updating the comparing array with the new expected toArray results: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		expectingArray = new Book[] { miamiWeekly, codeInterview, uniformWashing };
		
		// Expecting toArray to equals: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Miami Weekly", "Map") ("Cracking the Coding Interview 101", "James Crawford") ("Properly Washing a Uniform", "Dr. Bonson")
		
		// **** TESTING WITH TWO BOOKS ****
		
		// Removing one book from the arraySet: ("Miami Weekly", "Map")
		arraySet.remove(miamiWeekly);
		
		// Updating the comparing array with the new expected toArray results: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		expectingArray = new Book[] { uniformWashing,codeInterview };
		
		// Expecting toArray to equals: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		assertArrayEquals(arraySet.toArray(), expectingArray);
		// Returns: ("Properly Washing a Uniform", "Dr. Bonson") ("Cracking the Coding Interview 101", "James Crawford") 
		
		
	}

}
