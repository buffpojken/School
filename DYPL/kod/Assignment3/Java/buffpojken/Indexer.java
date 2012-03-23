package buffpojken;
import java.io.*;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;
import java.util.Vector;

public class Indexer {
	HashMap<String,Vector<String>> index;      
	static Map<Character,Character> reverse_map;
	
	public Indexer(String filename){
		// Setup index
		index = new HashMap<String,Vector<String>>();
		this.index(filename);
	}

	public boolean has(String k){
		return index.containsKey(k);
	}
	
	public Vector<String> get(String k){
		return index.get(k);
	}
	
	public void index(String filename){
		try{
			FileInputStream fstream = new FileInputStream(filename);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine, number;
			while((strLine = br.readLine()) != null){
				strLine = strLine.trim();
				number = Indexer.numberFromWord(strLine);
				if(!this.index.containsKey(number)){
					this.index.put(number, new Vector<String>());
				}
				this.index.get(number).add(strLine);
			}                             
			in.close();       
		}catch(Exception e){
			System.err.println("Error: " + e.getMessage());
		}
	}
	
	public static String numberFromWord(String word){
		String num = "";
		char[] charList = word.trim().toLowerCase().toCharArray();
		for(char c:charList){
			num += Indexer.reverse_map.get(c);
		}		
		return num;
	}
	
	static{
		HashMap<Character,Character> tmpReverse = new HashMap<Character,Character>();
		tmpReverse.put('a', '5');		
		tmpReverse.put('b', '7');
		tmpReverse.put('c', '6');
		tmpReverse.put('d', '3');
		tmpReverse.put('e', '0');
		tmpReverse.put('f', '4');
		tmpReverse.put('g', '9');
		tmpReverse.put('h', '9');
		tmpReverse.put('i', '6');
		tmpReverse.put('j', '1');
		tmpReverse.put('k', '7');
		tmpReverse.put('l', '8');
		tmpReverse.put('m', '5');
		tmpReverse.put('n', '1');
		tmpReverse.put('o', '8');
		tmpReverse.put('p', '8');
		tmpReverse.put('q', '1');
		tmpReverse.put('r', '2');
		tmpReverse.put('s', '3');
		tmpReverse.put('t', '4');
		tmpReverse.put('u', '7');
		tmpReverse.put('v', '6');
		tmpReverse.put('w', '2');
		tmpReverse.put('x', '2');
		tmpReverse.put('y', '3');
		tmpReverse.put('z', '9');
		reverse_map = Collections.unmodifiableMap(tmpReverse);
	}
	
}
