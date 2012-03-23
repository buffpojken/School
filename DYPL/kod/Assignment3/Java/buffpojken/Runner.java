package buffpojken;
import buffpojken.Indexer;
import buffpojken.Cartesian;
import buffpojken.Reader;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;

public class Runner {
	static Indexer mainIndex;
	static HashMap<String, Vector<Vector<String>>> glob;
	static Vector<String> stack;
	static Vector<Vector<String>> result;
	
	public static void main(String args[]){
		glob 	= new HashMap<String, Vector<Vector<String>>>();
		stack 	= new Vector<String>();
		result	= new Vector<Vector<String>>();
		
		mainIndex 			= new Indexer(args[0]);	
		Reader numReader	= new Reader(args[1]);
		Runner r 			= new Runner();
		int k = 0;
		while(numReader.hasNext()){			
			String number = numReader.next();
			number = number.replace("-", "");
			r.map(number, number);
			HashMap<String, ArrayList<String>> output = Runner.reduce(Runner.glob);
			Iterator it = output.entrySet().iterator();
			while(it.hasNext()){
				Map.Entry<String, ArrayList<String>> pairs = (Map.Entry<String, ArrayList<String>>)it.next();
				for(String s:pairs.getValue()){
					System.out.println(pairs.getKey()+": "+s.toLowerCase());
				}
			}
			Runner.glob.clear();
		}		
	}

	public Runner(){
	}
	
	public void map(String query, String original){
		String stack = "";
		for(char c: query.toCharArray()){
			stack += c;
			if(Runner.mainIndex.has(stack)){
				Runner.stack.add(stack);
				Runner.result.add(Runner.mainIndex.get(stack));
				String query2 = new String(query.substring(stack.length()));
				this.map(query2, original);
			}
		}
		String[] num = (String[])Runner.stack.toArray(new String[0]);
		String p = Runner.join(num, "");
		if(p.length() == original.length()){
			Runner.glob.put(p, new Vector<Vector<String>>(Runner.result));
		}
		Runner.stack.clear();
		Runner.result.clear();
		return;
	}
	
	// Just a basic implementation if a regular join for string[] 
	private static String join(String[] input, String delimiter)
	{
	    StringBuilder sb = new StringBuilder();
	    for(String value : input)
	    {
	        sb.append(value);
	        sb.append(delimiter);
	    }
	    int length = sb.length();
	    if(length > 0)
	    {
	        // Remove the extra delimiter
	        sb.setLength(length - delimiter.length());
	    }
	    return sb.toString();
	}
	
	
	
	public static HashMap<String, ArrayList<String>> reduce(HashMap<String, Vector<Vector<String>>> arg){
		HashMap<String, ArrayList<String>> result = new HashMap<String, ArrayList<String>>();
		Iterator it = arg.entrySet().iterator();
		while(it.hasNext()){
			Map.Entry<String, Vector<Vector<String>>> pairs = (Map.Entry<String, Vector<Vector<String>>>)it.next();
			Cartesian c = new Cartesian(pairs.getValue().toArray(new Vector[0]));
			ArrayList list = new ArrayList();
			while(c.hasNext()){
				Object[] a = c.next();
				String[] stringArray = Arrays.copyOf(a, a.length, String[].class);
				list.add(Runner.join(stringArray, " "));
			}			
			result.put(pairs.getKey(), list);
		}
		return result;
	}
	
}
