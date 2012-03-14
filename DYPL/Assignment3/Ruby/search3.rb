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


def search(num, res)
	current = "" 
	num.each_char do |letter|
		current += letter            
		if @db.key?(current)
			res[current] = @db[current]
			d = num.gsub(current, "")       
			search(d, res) unless d.length == 0
		end
	end
	return res
end

#nums.each do |num|
puts search("107835", {}).inspect
#end




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