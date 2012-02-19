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
				dc = Decontextualizer.set(_n, d)
				if d.is_a?(tp) || d.nil? 
					if @@constraints[_n].all?{|c| dc.check(c)}
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
					dc = Decontextualizer.set(_n, a)
					if @@constraints[_n].all?{|c| dc.check(c)}
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
	
	class Decontextualizer
		def self.set(name, value)
			define_method(name.to_s) do 
				return value
			end         
			return self.new  			
		end             
		def check(cntr)
			return !!eval(cntr, binding)
		end
	end
	                               
end