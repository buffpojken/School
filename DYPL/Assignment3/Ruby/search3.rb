require 'benchmark'

require './test_indexer'
require './utils'     

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

@glob = {}                 
@res = {}
@stack = []       
@res_stack = []       
@db = {}

def map(num, pivot, o)
	stack = ""         
	num.each_char do |letter|
		stack += letter        
		ind = (pivot == -1 ? stack.length : pivot)  
		if @db.key?(stack)
			@stack.push stack     
			@res_stack.push @db[stack]
 			query = num.gsub(num.slice!(0..stack.length-1),"")
			map(query, stack.length, o)
		end
	end          
	@glob[@stack.join("")] = @res_stack if @stack.join("").length == o.length
	@res = {}              
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

if ARGV[0] == 'bm'
Benchmark.bm do |x|
	x.report("Indexer:"){ indexer }
	x.report("Map:") do 
		File.open('nums', 'r').each_line do |n|     
			n.strip!
			m = map(n.dup, -1, n)   
		end		
	end             	
	x.report("Reduce:") do 
		@res = reduce(@glob)		
	end
	x.report("Drawing:") do 
		@res.each_pair do |phone, result|
			result.each_with_index do |r, i|       
				if ARGV[1] == 'np'
					# Do nothing
				else
					puts phone + ": " + r.join(" ").downcase.strip
				end
			end
		end                                       
	end
end   

else
	indexer
	 File.open('nums', 'r').each_line do |n|     
		n.strip!
		m = map(n.dup, -1, n)   
	end		
	 @res = reduce(@glob)		
	 	@res.each_pair do |phone, result|
			result.each_with_index do |r, i|
				puts phone + ": " + r.join(" ").downcase.strip
			end
		end                                       
	
end