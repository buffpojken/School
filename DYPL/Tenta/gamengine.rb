class Object
 def reset(c)  
  c.class_eval{ alias_method :__to_s, :to_s }
  c.instance_methods.map do |a| 
    c.send(:undef_method, a) unless a.match(/^__|object_id/)
  end
  c.class_variables.map{|a| c.send(:remove_class_variable, a)}
  c.class_eval do 
   def to_s
    return __to_s+"<reset>"
   end
  end
 end
end


