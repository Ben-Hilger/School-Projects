import java.io.File;
import java.io.FileNotFoundException;
import java.util.Iterator;
import java.util.Scanner;

public class Driver {

	public static void main(String[] args) {

		Name name1 = new Name("Jean", "Smith");
		Name name2 = new Name("Jean", "Smith");
		Name name3 = new Name("Amy", "Jones");
		Name name4 = new Name("Rhonda", "Jones");

		///////////////////////////////////////////////////////////////
		// TODO #1: Implement equals for the Name class.
		// The parameter type should be Object		
		// 5 Points
		System.out.println("These two calls to equals should be true: ");
		System.out.println(name1.equals(name2)); // Should be true
		System.out.println(name1.equals(name1)); // should be true
		
		System.out.println("These two calls to equals should be false: ");
		System.out.println(name1.equals("cat"));
		System.out.println(name1.equals(null)); 
		

		///////////////////////////////////////////////////////////////
		// TODO #2: Implement compareTo for the Name class and make sure 
		// the test cases below work correctly.
		// This should return a negative value because "Jones" comes before
		// "Smith":
		// 10 Points
		System.out.println("should be negative: " + name3.compareTo(name1));
		// This should return a negative value because both have the last name "Jones"
		// but "Amy" comes before "Rhonda"
		System.out.println("should be negative: " + name3.compareTo(name4));
		// This should return a positive value because "Smith" comes after
		// "Jones":
		System.out.println("should be positive: " + name1.compareTo(name3));
		// These should return zero because the two names are equal:
		System.out.println("should be zero: " + name1.compareTo(name2));
		System.out.println("should be zero: " + name2.compareTo(name1));
		
		///////////////////////////////////////////////////////////////
		// TODO #3: Declare a DictionaryInterface reference called phonebook 
		// and initialize using an object of SortedDictionary class.
		// Like all dictionaries, you add two pieces: a KEY and a VALUE
		// The KEY is what you use to find the VALUE.
		// For example, if you want someone's phone number, you look them up
		// by name (that's the key) so that you can get their number (that's the value).
		// You can do something like this:
		// DictionaryInterface<Key, Value> dictionaryName = DictionaryImplementationClass<Key, Value>();
		// Now, you have to decide the name of the reference, use the appropriate dictionary implementation,
		// and correct classes for the key and value.
		// 10 points
		// Write the java statement
		DictionaryInterface<Name, String> phoneBook = new SortedArrayDictionary<>();

		// Amy Young's phone number is 513-523-5123.  Add her to the phoneList.  What does
		// the method return, and why? 
		// Write the java statement
		// Use print statements to write the answer to "why".
		// Write the java statement
		// 10 Points
		Name amy = new Name("Amy", "Young");
		System.out.println("\nThe add(Key, Value) method will return null to indicate that it was added successfully");
		System.out.println("Adding Amy Young's phone number (513-523-5123) returns: " +  phoneBook.add(amy, "513-523-5123"));
		System.out.println("If a value already existed with her name as the key it would've been overwritten and the old value would've been returned");
		
		
		// Steve Buscemi's phone number is 814-454-3695  Add him to the phoneList.
		// Write the java statement
		// 5 Points
		Name steve = new Name("Steve", "Buscemi");
		phoneBook.add(steve, "814-454-3695");
		
	
		
		// How do you look up Amy's phone number?
		// Write the java statement and output using a print statement.
		// 5 Points
		System.out.println("Amy's phone number is: " + phoneBook.getValue(amy));
		
		
		// Use the add() method to change Amy's phone number.  What does the method return?
		// Write the java statement and output using a print statement.
		// 5 Points
		System.out.println("\nChanging Amy's phone number to 740-418-5532, add() method returns old phone number: " + phoneBook.add(amy, "740-418-5532") + "\n");
		
		
		// How do you remove Steve from the phoneList?
		// Write the java statement and output using a print statement.
		// 5 Points
		phoneBook.remove(steve);
		
		
		// How do you remove everyone from the phoneList?
		// Write the java statement
		// 5 Points
		phoneBook.clear();
		
		// TODO #4: phonedata.txt contains 100 lines of phone data.  Add all of them to the
		// phonebook.
		// 20 Points
		try {
			
			Scanner scan = new Scanner(new File("phonedata.txt"));
			
			for(int i = 0; i < 100; i++) {
				Name name = new Name(scan.next(), scan.next());
				phoneBook.add(name, scan.next());
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		// TODO #5: Complete the following code block to show dictionary content using key iterator and value iterator.
		// 20 points

		// Get the key iterator by calling the getKeyIterator()
		Iterator<Name>  keyIterator   = phoneBook.getKeyIterator();
		// Get the value iterator by calling the getValueIterator()
		Iterator<String> valueIterator = phoneBook.getValueIterator();

		// Write a condition in the while loop to explore all keys and values. There is a method called hasNext() in the iterator class.
		// You can use either the keyIterator or valueIterator
		while (keyIterator.hasNext())  
		{
			// get the next key from the keyIterator
			Name key = keyIterator.next(); 
			// get the next value from the valueIterator
			String value = valueIterator.next();
			
			System.out.println(key + " " + value);
		} // end while    

	}
	
}
