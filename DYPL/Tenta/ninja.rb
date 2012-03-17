module RackCompliance
	
	def call(env)               
		method = env['REQUEST_METHOD'].downcase.to_sym
		if self.respond_to?(method)
			data = self.send(method)
			(data.is_a?(Array) && data.length == 3) ? data : [500, {}, "Return value not compatible"]
		else
			
		end
	end
	
end

class Ninja 
	include RackCompliance
	def get
		return [200, {}, "Negerkung!"]
	end
end