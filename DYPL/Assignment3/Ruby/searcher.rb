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

def lookup(ind, numb, list)
	suffix_start = @mapping[numb.to_s[0].to_i]
	suffix_start.each do |sf|
		if ind[sf]                                
			list.push lookup(ind[sf], numb.to_s[1..-1], list)
		else
			puts list.inspect
			return list
		end
	end
end

lookup(@@index, 562482, [])