load 'test_indexer.rb'
load 'utils.rb'     

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

num = "562482"
                 
@res = {}

#puts @db
def map(num, pivot)
	stack = ""      
	num.each_char do |letter|
		stack += letter        
		ind = (pivot == -1 ? stack.length : pivot)  
		if @db.key?(stack)
			@res[stack.length] ||= []
			@res[stack.length].push({stack => @db[stack]})
			query = num.gsub(num.slice!(0..stack.length-1),"")
			map(query, stack.length)
		end
	end                                    
	return
end      

def reduce(res, num)
	puts res.keys
	# res.map do |k,v|
	# 	word = v.flatten.join(" ")
	# 	word.gsub(/\s/, "").length == num.length ? word : nil
	# end
end

n = "562482"
m = map(n.dup, -1)
puts @res.inspect    
#puts reduce(@res, n).inspect



# def search(num, res)
# 	current = "" 
# 	num.each_char do |letter|
# 		current += letter            
# 		if @db.key?(current)
# 			res[current] = @db[current]
# 			d = num.gsub(current, "")       
# 			search(d, res) unless d.length == 0
# 		end
# 	end
# 	return res
# end

# def search(num)
# 	res = []
# 	current = ""
# 	num.each_char do |letter|
# 		current += letter
# 		if @db.key?(current)
# 			res.push(@db[current])
# 			d = num.gsub(current, "")
# 			puts d
# 		end
# 	end
# 	return res
# end