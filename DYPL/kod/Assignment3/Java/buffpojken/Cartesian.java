package buffpojken;
import java.util.Iterator;

/**
 * Iterates over Cartesian product for an array of Iterables, 
 * Returns an array of Objects on each step containing values from each of the Iterables.
 *
 * @author jacek.p.kolodziejczyk@gmail.com
 * @created 01-08-2010
 */
public class Cartesian implements Iterator<Object[]> {

	private final Iterable[] iterables;
	private final Iterator[] iterators;
	private Object[] values;
	private int size;
	private boolean empty;

	/**
	 * Constructor
	 * @param iterables array of Iterables being the source for the Cartesian product.
	 */
	public Cartesian(Iterable[] iterables) {
		this.size = iterables.length;
		this.iterables = iterables;
		this.iterators = new Iterator[size];
		
		// Initialize iterators
		for (int i = 0; i < size; i++) {
			iterators[i] = iterables[i].iterator();
			// If one of the iterators is empty then the whole Cartesian product is empty
			if (!iterators[i].hasNext()) {
				empty = true;
				break;
			}
		}
		
		// Initialize the tuple of the iteration values except the last one
		if (!empty) {
			values = new Object[size];
			for (int i = 0; i < size-1; i++) setNextValue(i);
		}
	}

	@Override
	public boolean hasNext() {
		if (empty) return false;
		for (int i = 0; i < size; i++)
			if (iterators[i].hasNext())
				return true;
		return false;
	}

	@Override
	public Object[] next() {
		// Find first in reverse order iterator the has a next element
		int cursor;
		for (cursor = size-1; cursor >= 0; cursor--)
			if (iterators[cursor].hasNext()) break;

		// Initialize iterators next from the current one  
		for (int i = cursor+1; i < size; i++) iterators[i] = iterables[i].iterator();
		
		// Get the next value from the current iterator and all the next ones  
		for (int i = cursor; i < size; i++) setNextValue(i);

		return values.clone();
	}

	/**
	 * Gets the next value provided there is one from the iterator at the given index. 
	 * @param index
	 */
	private void setNextValue(int index) {
		Iterator it = iterators[index];
		if (it.hasNext())
			values[index] = it.next();
	}

	@Override
	public void remove() { throw new UnsupportedOperationException(); }
}