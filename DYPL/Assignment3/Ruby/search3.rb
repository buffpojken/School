require 'benchmark'

require './test_indexer'
require './utils'     

@glob = {}                 
@stack = []       
@res_stack = []       
@db = {}

def map(num, o)
	stack = ""     
	num.each_char do |letter|
		stack += letter    
		if @db.key?(stack)           
			@stack.push stack        
			@res_stack.push @db[stack]
 			query = num.gsub(num.dup.slice!(0..stack.length-1),"")
			map(query, o)
	  end
	end                            
	@glob[@stack.join("")] = Array::new(@res_stack) if @stack.join("").length == o.length
	@stack = []
	@res_stack = []
	return
end      

def reduce(res)   
	res.each_pair do |number, value_list|   
		res[number] = cartprod(*value_list)
	end             
	res
end    

		indexer
		i = 0
		File.open('nums', 'r').each_line do |n|     
			n.gsub("-", "").strip!    
			m = map(n.dup, n)   
			@res = reduce(@glob) 
			@res.each_pair do |phone, result|  
				result.each_with_index do |r, i|       
						puts phone + ": " + r.join(" ").downcase.strip
				end
			end                                       
			@glob = {}    
			i += 1
		end		
       