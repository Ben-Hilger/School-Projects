
public class ArrayUtility implements UtilityInterface<Integer> {

	public static final int DEFAULT_CAPACITY = 10;
	
	private Integer[] intEntries;
	private int last = 0;
	
	public ArrayUtility() {
		intEntries = new Integer[DEFAULT_CAPACITY];
	}
	
	public ArrayUtility(int capacity) {
		intEntries = new Integer[capacity];
	}
	
	@Override
	public void clear() {
		intEntries = new Integer[intEntries.length];
		last = 0;
	}

	@Override
	public int getCurrentSize() {
		return last;
	}

	@Override
	public boolean isEmpty() {
		return last == 0;
	}

	@Override
	public boolean contains(Integer anElement) {
	
		for(int index = 0; index < last; index++) {
			if(intEntries[index].equals(anElement)) {
				return true;
			}
		}
		
		return false;
	}

	@Override
	public Integer get(int index) {
		
		Integer result = null;
		
		if(index < last && index >= 0) {
			result = intEntries[index];
		}
		
		return result;
	}

	@Override
	public int indexOf(Integer anElement) {
		
		for(int i = 0; i < last; i++) {
			if(intEntries[i].equals(anElement)) {
				return i;
			}
		}
		
		return -1;
	}

	@Override
	public int getFrequencyOf(Integer anElement) {
		
		int freq = 0;
		
		for(int i = 0; i < last; i++) {
			if(intEntries[i].equals(anElement)) {
				freq++;
			}
		}
		
		return freq;
	}

	@Override
	public boolean add(Integer anElement) {
		
		if(last >= intEntries.length) {
			return false;
		}
		
		intEntries[last] = anElement;
		last++;
		
		return true;
	}

	@Override
	public boolean add(Integer anElement, int index) {
		
		
		if(index > last || index < 0 || last == intEntries.length) 
			return false;
		
		for(int i = index+1; i < last; i++) {
			intEntries[i] = intEntries[i-1];
		}
		
		
		last++;
		intEntries[index] = anElement;
		
		return true;
	}

	@Override
	public boolean remove(Integer anElement) {
	
		if(!contains(anElement))
			return false;
		
		int index = this.indexOf(anElement);
		
		last--;
		for(int i = index+1; i < intEntries.length; i++) {
			intEntries[i-1] = intEntries[i];
			intEntries[i] = null;
		}
		
		
		return true;
	}

	@Override
	public boolean removeFirst() {
		
		if(isEmpty()){ 
			return false;
		}
			
		last--;
		for(int i = 1; i < intEntries.length; i++) {
			intEntries[i-1] = intEntries[i];
			intEntries[i] = null;
		}
		
		
		return true;
	}

	@Override
	public boolean removeLast() {
		
		if(isEmpty()){
			return false;
		}
		
		last--;
		intEntries[last] = null;
		
		return true;
		
	}

	@Override
	public boolean removeMiddle() {
		
		if(isEmpty()) {
			return false;
		}
		
		int indexToRemove = last/2;
		
		if(last % 2 == 0) {
			indexToRemove = (last-1)/2;
		}
		
		last--;
		for(int i = indexToRemove+1; i < last; i++) {
			intEntries[i-1] = intEntries[i];
			intEntries[i] = null;
		}
		
		return true;
	}

	public void reverse() {
		
		for(int i = 0; i < last/2; i++) {
			int currentValue = intEntries[i];
			int reverseValue = intEntries[(last-1)-i];
			
			intEntries[i] = reverseValue;
			intEntries[(last-1)-i] = currentValue;
		}
	}
	
}
