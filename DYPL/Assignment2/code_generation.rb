module Model

	def self.generate(spec) 
		@current = Class.new(Model::Base)   
		@current.class_eval do 
			@@constraints = {}
		end
		spec = File.open(spec)
		class_eval(spec.read)
	end
	def self.attribute(_n, tp)
		@current.class_eval do
			define_method(_n) do     
				d = instance_variable_get(("@"+_n.to_s).to_sym);
				if d.is_a?(tp) || d.nil?        
					if @@constraints[_n].all?{|c| self.instance_eval(c)}					    
						return d
					else
						raise ("#{_n} does not satisfy conditions")
					end
			 	else
					raise ("#{_n} is of wrong type, should be a #{tp.name}")
				end
			end
		end
		@current.class_eval do        
			define_method((_n.to_s+"=").to_sym) do |a|
				if a.is_a?(tp)         
					instance_variable_set(("@"+_n.to_s).to_sym, a)
					if @@constraints[_n].all?{|c| self.instance_eval(c)}
						return a
					else
						raise ("#{_n} does not satisfy conditinos")						
					end
				else
					raise ("#{_n} is of wrong type, should be a #{tp.name}")
				end
			end			
		end
	end

	def self.constraint(name, cnstr)
		@current.class_eval do
		 (@@constraints[name] ||= []).push(cnstr)
		end
	end

	def self.title(name)      
		# Use eval to force this to execut in global scope, since we're writing
		# to global namespace .daniel
		eval("::#{name} = @current")
	end

	class Base
		    
	end                                    
end