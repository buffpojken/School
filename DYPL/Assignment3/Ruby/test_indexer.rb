
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

def number_from_word(word)
	word.strip.downcase.split("").map!{|char| @reverse_map[char] }.join("")
end      


def indexer
	f = File.open('huge_dictionary.txt', 'r')
	f.each_line do |word|
		digit = number_from_word(word)
		(@db[digit] ||= []).push(word.strip)
	end
end               

