require 'benchmark'

@@index = {}

def put(level, rest)  
	if rest.length == 0		
		return nil
	end             
	k = rest.slice!(0)
	level[k] ||= {}         
	put(level[k], rest)
end

@@index_time = Benchmark.bm(7) do |t|
	t.report("time:") do 
		words = File.open('testdict.txt', 'r').readlines.map{|w| w.strip }
		words.each do |word|
			put(@@index, word.downcase)
		end
	end
end