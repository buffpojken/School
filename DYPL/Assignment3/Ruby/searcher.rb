load 'indexer.rb'

phones = %w{562482}
               
# 112
# 562482
# 4824
# 07216084067
# 107835
# 10789135
# 381482
# 04824

@mapping = [
	['e'], 
	['j', 'n', 'q'],
	['r', 'w', 'x'], 
	['d', 's', 'y'], 
	['f', 't'], 
	['a', 'm'], 
	['c', 'i', 'v'], 
	['b', 'k', 'u'], 
	['l', 'o', 'p'], 
	['g', 'h', 'z']
]

def expand(number)
	data = []
	number.to_s.each_char do |char|
		data.push @mapping[char.to_i]
	end                            
	return data
end

# def lookup(ind, numb, list)
# 	suffix_start = @mapping[numb.to_s[0].to_i]
# 	suffix_start.each do |sf|
# 		if ind[sf]                                
# 			list.push lookup(ind[sf], numb.to_s[1..-1], list)
# 		else
# 			puts list.inspect
# 			return list
# 		end
# 	end
# end   

@db = {}

def lookup2(ind, leafs, step)
	return if leafs.length == step
	leafs[step].each do |letter|
		if ind.key?(letter) 
			puts letter.inspect
			lookup2(ind[letter], leafs, step + 1)
		else
			
		end
	end
end

da = expand(562482)

lookup2(@@index, da, 0)