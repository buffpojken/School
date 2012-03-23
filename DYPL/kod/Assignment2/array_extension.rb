class Array
	  
	def select_first(args)
		proc = _select(args, :single) 
		proc.call
	end               
	
	def select_all(args)
		proc = _select(args, :all) 
		proc.call
	end

	private    

	def _select(args, arity)
	 return args.key?(:interval) ? range_proc(args, arity) : single_proc(args, arity)
	end
	
	def single_proc(data, arity)
		Proc.new do 
			p = Proc.new do |obj|                              
				t = true
				data.each_pair{|k,v| t = Array(v).include?(obj.send(k))}
				t
			end              
			arity.eql?(:single) ? self.find{|a| p.call(a) } : self.find_all{|a| p.call(a) }
		end
	end
	
	def range_proc(data, arity)
		Proc.new do 
			range_data = data.delete(:interval)		  
			# Since the spec doesn't specify the lower bound when not specified, we're using
			# the systems-specific lowest fixnum boundary .daniel 
			range = Range.new((range_data[:min] || -(2**(0.size * 8 -2) -1)), range_data[:max])
			p = Proc.new do |obj|
				t = true
				data.each_pair {|k,v| t = range.include?(obj.send(data[:name])) }
				t
			end                              
			arity.eql?(:single) ? self.find{|a| p.call(a) } : self.find_all{|a| p.call(a)}
		end
	end
	
	def method_missing(name, *args, &block)   
		match = name.to_s.match(/select_(first|all)_where_([a-zA-Z!?]+)_is(_in)?/)
		if match 
			_scope = match[1].eql?("first")
			if match[3].nil?   
				_d = {match[2].to_sym => args[0]}
				p = _scope ? _select(_d, :single) : _select(_d, :all)
				Array.class_eval do 
					define_method(name) do |*_args|
						_select({match[2].to_sym => _args[0]}, (_scope ? :single : :all)).call
					end
				end
			else    
				_d = {:name => match[2].to_sym,:interval => {:min => args[0], :max => args[1]}}
				p = _scope ? _select(_d, :single) : _select(_d, :all)   
				Array.class_eval do 
					define_method(name) do |*_args|
						_select({:name => match[2].to_sym, :interval => {:min => _args[0], :max => _args[1]}}, (_scope ? :single : :all)).call
					end
				end
			end      
			p.call
		else
			super
		end
	end
	
	def respond_to?(name)
		return name.to_s.match(/select_(first|all)_where_([a-zA-Z!?]+)_is(_in)?/)
	end
	
end
