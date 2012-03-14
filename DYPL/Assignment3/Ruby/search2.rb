
@reverse_map = {
	'a' => '5', 
	'b' => '7', 
	'c' => '6', 
	'd' => '3',
	'e' => '0', 
	'f' => '4', 
	'g' => '9', 
	'h' => '9', 
	'i' => '6', 
	'j' => '1', 
	'k' => '7', 
	'l' => '8', 
	'm' => '5', 
	'n' => '1', 
	'o' => '8', 
	'p' => '8', 
	'q' => '1', 
	'r' => '2', 
	's' => '3', 
	't' => '4', 
	'u' => '7', 
	'v' => '6', 
	'w' => '2', 
	'x' => '2', 
	'y' => '3', 
	'z' => '9' 
}                 

def format(result, num)     
	 d = []
	result.each do |r|
		if d.length == 0
			d.push *r
		else			
			r.each{|a| d.map!{|q| q += " " +a}} unless r.nil?
		end
	end 
	d.reject!{|a| a.gsub(/\s/, "").length != num.length }     
	return d	
end

def number_from_word(word)
	word.strip.downcase.split("").map!{|char| @reverse_map[char] }.join("")
end      

@db = {}
def indexer
	f = File.open('testdict.txt', 'r')
	f.each_line do |word|
		digit = number_from_word(word)
		(@db[digit] ||= []).push(word.strip)
	end
end               
indexer                                      

def search(num, step, result)  
	if step == num.length 
		return result
	end
	if @db.key?(num)
		result.push(@db[num])
		return result
	elsif @db.key?(num[0..step])
		result.push @db[num[0..step]]
		num.slice!(0, step+1)
		search(num, 0, result)						
	else
		search(num, step+1, result)
	end
end      


#File.open('nums', 'r').each_line do |number|
nums = %w{
	112
	562482
	4824
	07216084067
	107835
	10789135
	381482
	04824
} 
nums.each do |number|
 clone = number.dup
	result = format(search(number.strip, 1, []), clone)
	result.each do |enc|
		puts clone.strip+": " + enc.downcase.strip
	end
end
