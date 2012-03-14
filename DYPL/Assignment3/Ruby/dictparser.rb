f = File.new('dict.txt', 'w')
r = File.open('_dict.txt', 'r')
data = r.readlines.join("")
data.split(",").each do |word|
	 f.puts word.chomp.strip
end