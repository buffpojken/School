class Array
	  
	def select_first(args)
		proc = args.key?(:interval) ? range_proc(args, :single) : single_proc(args, :single) 
		# cache method here
	end               
	
	def select_all(args)
		proc = args.key?(:interval) ? range_proc(args, :all) : single_proc(args, :all) 
		# cache method here		
	end

	private
	
	def single_proc(data, arity)
		p = Proc.new do |obj|                              
			t = true
			data.each_pair{|k,v| t = Array(v).include?(obj.send(k))}
			t
		end              
		return arity.eql?(:single) ? self.find{|a| p.call(a) } : self.find_all{|a| p.call(a) }
	end
	
	def range_proc(data, arity)
		range_data = data.delete(:interval)		   
		range = Range.new((range_data[:min] || 0), range_data[:max])
		p = Proc.new do |obj|
			t = true
			data.each_pair {|k,v| t = range.include?(obj.send(data[:name])) }
			t
		end                              
		return arity.eql?(:single) ? self.find{|a| p.call(a) } : self.find_all{|a| p.call(a)}
	end
	
	def method_missing(name, *args, &block)
		match = name.to_s.match(/select_(first|all)_where_([a-zA-Z!?]+)_is(_in)?/)
		if match
			match[3].nil? ? single_proc({match[2].to_sym => args[0]}, match[1].eql?("first") ? :single : :all) : range_proc({:name => match[2].to_sym,:interval => {:min => args[0], :max => args[1]}}, match[1].eql?("first") ? :single : :all)
		else
			super
		end
	end
	
	def respond_to?(name)
		return name.to_s.match(/select_(first|all)_where_([a-zA-Z!?]+)_is(_in)?/)
	end
	
end
