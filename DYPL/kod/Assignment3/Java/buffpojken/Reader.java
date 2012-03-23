package buffpojken;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.Vector;

public class Reader implements Iterator<String>{
	int mark;
	ArrayList<String> data;
	
	public Reader(String file){
		this.mark = 0;
		this.data = new ArrayList<String>();
		try{
			FileInputStream fstream = new FileInputStream(file);
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;
			while((strLine = br.readLine()) != null){
				strLine = strLine.trim();
				this.data.add(strLine);
			}                             
			in.close();       
		}catch(Exception e){
			System.err.println("Error: " + e.getMessage());
		}
	}

	@Override
	public boolean hasNext() {
		return this.data.size() > this.mark;
	}

	@Override
	public String next() {
		String s = this.data.get(this.mark);
		this.mark++;
		return s;
	}

	@Override
	public void remove() { throw new UnsupportedOperationException(); }

	
}
